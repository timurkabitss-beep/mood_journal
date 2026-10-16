import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import '../../../../../../../../core/database/hive_box.dart'; // Путь к твоим константам HiveBoxes
import '../../../../../../../../ui/fonts/all_fonts.dart';

class InfoJournalWidget extends StatelessWidget {
  const InfoJournalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Виджет сам слушает базу Hive и перерисовывается при изменениях
      child: ValueListenableBuilder(
        valueListenable: Hive.box<MoodEntryModel>(HiveBoxes.moodJournalEntry).listenable(),
        builder: (context, Box<MoodEntryModel> box, _) {
          final count = box.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                count == 1 ? 'check-in' : 'check-ins',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}