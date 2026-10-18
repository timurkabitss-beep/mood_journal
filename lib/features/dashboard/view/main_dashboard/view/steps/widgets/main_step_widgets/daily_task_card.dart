import 'package:flutter/material.dart';
import 'package:mood_journal/core/data/mock_tasks.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/state/global_state.dart';
import '../../../../../../../../ui/fonts/all_fonts.dart';
import 'package:mood_journal/core/data/daily_task_helper.dart';

class DailyTaskCard extends StatelessWidget {
  final DateTime selectedDate;

  const DailyTaskCard({super.key, required this.selectedDate});

  String _getTaskForDate(DateTime date) => getTaskForDate(date);

  bool _isFutureDate(DateTime date) {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final target = DateTime(date.year, date.month, date.day);
    return target.isAfter(today);
  }

  @override
  Widget build(BuildContext context) {
    final currentTask = _getTaskForDate(selectedDate);
    final isFuture = _isFutureDate(selectedDate);
    final setCurrentIndex = context.read<AppState>().setCurrentIndex;

    return AnimatedOpacity(
      opacity: isFuture ? 0.7 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 160,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isFuture ? Icons.lock_outline : Icons.task_alt,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Daily Task',
                      style: daily_task_access
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Text(
                    currentTask,
                    key: ValueKey(selectedDate.toIso8601String()),
                    style: daily_task_text,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 16,
              right: 16,
              child: GestureDetector(
                onTap: isFuture ? null : () {
                  context.read<AppState>().openDailyTask(selectedDate);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isFuture ? Colors.grey.shade200 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isFuture ? 'Locked' : 'Open',
                        style: daily_task_access
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        isFuture ? Icons.lock : Icons.arrow_forward,
                        size: 16,
                        color: isFuture ? Colors.grey.shade500 : Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}