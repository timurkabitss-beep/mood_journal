import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/journal_screen_widgets/mood_entry_widget.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/journal_screen_widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../../core/database/repositories/mood_repository.dart';
import '../../../../../core/state/global_state.dart';
import '../../../../../ui/fonts/all_fonts.dart';

class JournalUserScreen extends StatelessWidget {
  const JournalUserScreen({super.key});

  static const int _historyDays = 30;
  static const double _baseMenuHeight = 70.0;

  @override
  Widget build(BuildContext context) {
    final setCurrentIndex = context.read<AppState>().setCurrentIndex;
    final mediaPadding = MediaQuery.of(context).padding;
    final repository = MoodRepository.instance;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          // Перестраивается автоматически при любом изменении записей в Hive
          ValueListenableBuilder(
            valueListenable: repository.listenable(),
            builder: (context, _, __) {
              final entries = repository.getEntriesForLastDays(_historyDays);

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
                  if (entries.isEmpty)
                    const SliverFillRemaining(
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
                        itemCount: entries.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 28),
                        itemBuilder: (_, i) => MoodEntryWidget(
                          key: ValueKey(entries[i].date),
                          entry: entries[i],
                        ),
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
              color: const Color(0xFF9FB3CC).withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back, color: Colors.grey, size: 30),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

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