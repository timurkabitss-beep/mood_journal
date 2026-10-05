import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'day_widget_card.dart';

class WeekCalendarCard extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const WeekCalendarCard({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getHeaderLabel(DateTime date) {
    final today = DateTime.now();
    final dateOnly = DateTime(date.year, date.month, date.day);
    final todayOnly = DateTime(today.year, today.month, today.day);
    final difference = dateOnly.difference(todayOnly).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';
    return DateFormat('EEEE').format(date);
  }

  String _getCardDayLabel(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final headerLabel = _getHeaderLabel(selectedDate);
    final headerFullDate = DateFormat("EEE, MMMM d").format(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Column(
            key: ValueKey(headerFullDate),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(headerLabel, style: const TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 4),
              Text(headerFullDate, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 70,
          child: GridView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
              childAspectRatio: 93/90,
            ),
            itemBuilder: (context, index) {
              final daysOffset = index - 2;
              final targetDate = DateTime.now().add(Duration(days: daysOffset));
              final isSelected = _isSameDay(targetDate, selectedDate);

              return GestureDetector(
                onTap: () => onDateSelected(targetDate),
                child: DayWidgetCard(
                  dayLabel: _getCardDayLabel(targetDate),
                  numDate: DateFormat('d').format(targetDate),
                  isSelectedDay: isSelected,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}