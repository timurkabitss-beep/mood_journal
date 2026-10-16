import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import '../../../../../../../../core/database/repositories/mood_repository.dart';
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
        valueListenable: MoodRepository.instance.listenable(),
        builder: (context, Box<MoodEntryModel> box, _) {
          final count = box.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: journal_info_count,
              ),
              Text(
                count == 1 ? 'check-in' : 'check-ins',
                style: journal_info_label,
              ),
            ],
          );
        },
      ),
    );
  }
}