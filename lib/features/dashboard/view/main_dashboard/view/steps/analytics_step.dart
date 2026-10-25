import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal/core/ai/mood_report_service.dart';
import 'package:mood_journal/core/database/repositories/mood_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';
import 'package:provider/provider.dart';

class AnalyticsStep extends StatefulWidget {
  const AnalyticsStep({super.key});

  @override
  State<AnalyticsStep> createState() => _AnalyticsStepState();
}

class _AnalyticsStepState extends State<AnalyticsStep> {
  static const double _baseMenuHeight = 70.0;

  int _days = 7;
  MoodReport? _report;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCached(_days);
  }

  Future<void> _loadCached(int days) async {
    final cached = await MoodReportService.instance.loadCached(days);
    if (!mounted || days != _days) return;
    setState(() => _report = cached);
  }

  void _selectPeriod(int days) {
    if (days == _days) return;
    setState(() {
      _days = days;
      _report = null;
    });
    _loadCached(days);
  }

  Future<void> _generate() async {
    if (_isLoading) return;

    final days = _days;
    final userName = context.read<AppState>().userName;
    setState(() => _isLoading = true);

    final report = await MoodReportService.instance.generate(
      days: days,
      userName: userName,
    );
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (report != null && days == _days) _report = report;
    });

    if (report == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Couldn't create the report. Please try again later.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaPadding = MediaQuery.of(context).padding;
    final repo = MoodRepository.instance;
    final themeColors = context.watch<AppState>().selectedTheme.colors;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        colors: themeColors,
        child: ListenableBuilder(
          listenable: Listenable.merge([
            repo.listenable(),
            repo.dailyAnswersListenable(),
            repo.challengesListenable(),
          ]),
          builder: (context, _) {
            final entries = repo.getEntriesForLastDays(_days);
            final tasks = repo.getDailyAnswersForLastDays(_days);
            final challenges = repo.getChallengesForLastDays(_days);
            final enough = entries.length >= MoodReportService.minEntries;

            // Самое частое настроение за период
            String topMood = '-';
            if (entries.isNotEmpty) {
              final counts = <String, int>{};
              for (final e in entries) {
                counts[e.mood.label] = (counts[e.mood.label] ?? 0) + 1;
              }
              topMood = counts.entries
                  .reduce((a, b) => a.value >= b.value ? a : b)
                  .key;
            }

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 110 + mediaPadding.top,
                left: 20,
                right: 20,
                bottom: _baseMenuHeight + mediaPadding.bottom + 40,
              ),
              child: Column(
                children: [
                  Text('Insights', style: insights_title),
                  const SizedBox(height: 24),

                  // Переключатель периода
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PeriodChip(
                        label: 'Last 7 days',
                        selected: _days == 7,
                        accent: themeColors[0],
                        onTap: () => _selectPeriod(7),
                      ),
                      const SizedBox(width: 12),
                      _PeriodChip(
                        label: 'Last 30 days',
                        selected: _days == 30,
                        accent: themeColors[0],
                        onTap: () => _selectPeriod(30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Статистика (считается без AI)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _Stat(
                                value: Text('${entries.length}',
                                    style: insights_stat_value),
                                label: 'CHECK-INS',
                              ),
                            ),
                            Expanded(
                              child: _Stat(
                                value: Text('${tasks.length}',
                                    style: insights_stat_value),
                                label: 'TASKS DONE',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _Stat(
                                value: Text('${challenges.length}',
                                    style: insights_stat_value),
                                label: 'CHALLENGES DONE',
                              ),
                            ),
                            Expanded(
                              child: _Stat(
                                value: Text(
                                  topMood,
                                  textAlign: TextAlign.center,
                                  style: insights_top_mood,
                                ),
                                label: 'TOP MOOD',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Отчёт AI
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.auto_awesome,
                                  size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text('AI Report', style: daily_task_access),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment.topCenter,
                          child: _buildReportBody(enough),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildReportBody(bool enough) {
    // 1. Мало данных
    if (!enough) {
      return Text(
        'Add at least ${MoodReportService.minEntries} check-ins in this period '
            'to get your report.',
        style: mood_support_hint,
      );
    }

    // 2. Идёт генерация
    if (_isLoading) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.grey.shade500),
                ),
              ),
              const SizedBox(height: 16),
              Text('Analyzing your entries...', style: mood_support_hint),
            ],
          ),
        ),
      );
    }

    final report = _report;

    // 3. Отчёта ещё нет
    if (report == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get a short summary of your last $_days days: how you felt, '
                'what influenced your mood and what could help.',
            style: report_text,
          ),
          const SizedBox(height: 20),
          Center(child: _buildGenerateButton('GENERATE REPORT')),
        ],
      );
    }

    // 4. Отчёт готов
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(report.summary, style: mood_support_text),
        if (report.patterns.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text('PATTERNS', style: report_section_title),
          const SizedBox(height: 8),
          _bullets(report.patterns),
        ],
        if (report.suggestions.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text('IDEAS FOR YOU', style: report_section_title),
          const SizedBox(height: 8),
          _bullets(report.suggestions),
        ],
        const SizedBox(height: 16),
        Text(
          'Created ${DateFormat('MMM d, HH:mm').format(report.createdAt)}. '
              'AI-generated, not medical advice.',
          style: mood_support_hint,
        ),
        const SizedBox(height: 20),
        Center(child: _buildGenerateButton('REFRESH')),
      ],
    );
  }

  Widget _bullets(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (text) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: report_text),
              Expanded(child: Text(text, style: report_text)),
            ],
          ),
        ),
      )
          .toList(),
    );
  }

  Widget _buildGenerateButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        minimumSize: const Size(220, 54),
        elevation: 0,
      ),
      onPressed: _generate,
      child: Text(
        label,
        style: style5.copyWith(color: Colors.grey.shade700),
      ),
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color accent;
  final VoidCallback onTap;

  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Text(
          label,
          style: insights_chip_text.copyWith(
            color: selected ? accent : Colors.white,
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final Widget value;
  final String label;

  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          value,
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: insights_stat_label),
        ],
      ),
    );
  }
}