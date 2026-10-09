import 'package:flutter/material.dart';

import '../../../../../../../../ui/fonts/all_fonts.dart';



class DayWidgetCard extends StatelessWidget {
  final String dayLabel;
  final String numDate;
  final bool isSelectedDay;


  const DayWidgetCard({
    super.key,
    required this.dayLabel,
    required this.numDate,
    required this.isSelectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 90,
        height: 70,
        decoration: BoxDecoration(
        color: isSelectedDay ? Colors.black.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dayLabel, style: week_calebdar_day_label),
            SizedBox(height: 4),
            Text(numDate, style:  week_calebdar_num_label),
          ],
        ) ,
    );
  }
}
