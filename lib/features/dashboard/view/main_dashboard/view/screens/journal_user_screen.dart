import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/journal_screen_widgets/mood_entry_widget.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/journal_screen_widgets/widgets.dart';
import 'package:mood_journal/features/mood/models/daily_answer_entry.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/database/repositories/mood_repository.dart';
import '../../../../../../core/state/global_state.dart';
import '../../../../../../ui/fonts/all_fonts.dart';

/// Один день журнала: настроение и/или задание
class _JournalDay {
  final DateTime date;
  MoodEntryModel? mood;
  DailyAnswerEntry? task;

  _JournalDay({required this.date, this.mood, this.task});
}

class JournalUserScreen extends StatelessWidget {
  const JournalUserScreen({super.key});

  static const int _historyDays = 30;
  static const double _baseMenuHeight = 70.0;

  static String _dayKey(DateTime d) => '${d.year}-${d.month}-${d.day}';

  /// Объединяем настроения и задания по дням, свежие сверху
  static List<_JournalDay> _buildDays(MoodRepository repo) {
    final moods = repo.getEntriesForLastDays(_historyDays);
    final tasks = repo.getDailyAnswersForLastDays(_historyDays);

    final days = <String, _JournalDay>{};

    for (final mood in moods) {
      days[_dayKey(mood.date)] = _JournalDay(date: mood.date, mood: mood);
    }
    for (final task in tasks) {
      final key = _dayKey(task.date);
      final existing = days[key];
      if (existing != null) {
        existing.task = task;
      } else {
        days[key] = _JournalDay(date: task.date, task: task);
      }
    }

    return days.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    final setCurrentIndex = context.read<AppState>().setCurrentIndex;
    final mediaPadding = MediaQuery.of(context).padding;
    final repository = MoodRepository.instance;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          // Перестраивается при любом изменении настроений или ответов
          ListenableBuilder(
            listenable: Listenable.merge([
              repository.listenable(),
              repository.dailyAnswersListenable(),
            ]),
            builder: (context, _) {
              final days = _buildDays(repository);

              return CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: 130 + mediaPadding.top,
                      left: 20,
                      right: 20,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Text(
                            'Your journal',
                            textAlign: TextAlign.center,
                            style: journal_title,
                          ),
                          const InfoJournalWidget(),
                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                  if (days.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        _baseMenuHeight + mediaPadding.bottom + 40,
                      ),
                      sliver: SliverList.separated(
                        itemCount: days.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 28),
                        itemBuilder: (_, i) {
                          final day = days[i];
                          return MoodEntryWidget(
                            key: ValueKey(_dayKey(day.date)),
                            date: day.date,
                            entry: day.mood,
                            task: day.task,
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
          Positioned(
            top: 90,
            left: 20,
            child: _BackButton(onTap: () => setCurrentIndex(3)),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back, color: Colors.grey, size: 30),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: Text(
          'No entries in the last 30 days',
          style: journal_empty_text,
        ),
      ),
    );
  }
}