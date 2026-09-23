import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets.dart';
import 'package:mood_journal/ui/fonts/font.dart';

class WeekCalendarCard extends StatefulWidget {
  const WeekCalendarCard({super.key});

  @override
  State<WeekCalendarCard> createState() => _WeekCalendarCardState();
}

class _WeekCalendarCardState extends State<WeekCalendarCard> {
  int _selectedIndex = 2;

  String _getCardDayLabel(DateTime date) {
    return DateFormat('EEE').format(date);
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

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final selectedDay = today.add(Duration(days: _selectedIndex - 2));

    final headerLabel = _getHeaderLabel(selectedDay);
    final headerFullDate = DateFormat("EEE, MMMM, d.").format(selectedDay);


    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 0),
              child: Column(
                key: ValueKey(headerFullDate),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(headerLabel, style: style1.copyWith(fontSize: 16)),
                  const SizedBox(height: 4,),
                  Text(headerFullDate, style: style3,),
                  const SizedBox(height: 24),

                  SizedBox(
                    height: 70,
                    child: GridView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            childAspectRatio: 98/90,
                        ),
                        itemBuilder: (context, index){
                          final daysOffset = index - 2;
                          final targetDate = DateTime.now().add(Duration(days: daysOffset));

                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            child: DayWidgetCard(
                                dayLabel: _getCardDayLabel(targetDate),
                                numDate: DateFormat('d').format(targetDate), // Просто число (22)
                                isSelectedDay: index == _selectedIndex
                            )
                          );
                        }
                    ),
                  ),
                ],
              ),
          )
        ],
    );
  }
}
