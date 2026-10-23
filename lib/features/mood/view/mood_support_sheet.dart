import 'package:flutter/material.dart';
import 'package:mood_journal/core/ai/mood_support_service.dart';
import 'package:mood_journal/core/database/repositories/mood_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';
import 'package:provider/provider.dart';

bool _sameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Открывает нижнее окно с заметкой от AI и ждёт, пока его закроют.
Future<void> showMoodSupportSheet(
    BuildContext context,
    MoodEntryModel entry,
    ) {
  final userName = context.read<AppState>().userName;

  // Настроения за предыдущие дни (без сегодняшней записи)
  List<String> recentMoods = const [];
  try {
    recentMoods = MoodRepository.instance
        .getEntriesForLastDays(8)
        .where((e) => !_sameDay(e.date, entry.date))
        .take(7)
        .map((e) => e.mood.label)
        .toList();
  } catch (_) {}

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _MoodSupportSheet(
      entry: entry,
      userName: userName,
      recentMoods: recentMoods,
    ),
  );
}

class _MoodSupportSheet extends StatefulWidget {
  final MoodEntryModel entry;
  final String? userName;
  final List<String> recentMoods;

  const _MoodSupportSheet({
    required this.entry,
    required this.userName,
    required this.recentMoods,
  });

  @override
  State<_MoodSupportSheet> createState() => _MoodSupportSheetState();
}

class _MoodSupportSheetState extends State<_MoodSupportSheet> {
  late final Future<String?> _future;

  @override
  void initState() {
    super.initState();
    _future = MoodSupportService.instance.getSupport(
      entry: widget.entry,
      userName: widget.userName,
      recentMoods: widget.recentMoods,
    );

    // Если AI недоступен, окно тихо закрывается и пользователь идёт дальше
    _future.then((text) {
      if (text == null && mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 32 + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          const SizedBox(height: 24),
          Text('A note for you', style: mood_support_title),
          const SizedBox(height: 20),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: FutureBuilder<String?>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 26,
                          width: 26,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.shade500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Thinking about your day...',
                          style: mood_support_hint,
                        ),
                      ],
                    ),
                  );
                }

                final text = snapshot.data;
                if (text == null) return const SizedBox.shrink();

                return Column(
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: mood_support_text,
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        minimumSize: const Size(220, 54),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'CONTINUE',
                        style: style5.copyWith(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}