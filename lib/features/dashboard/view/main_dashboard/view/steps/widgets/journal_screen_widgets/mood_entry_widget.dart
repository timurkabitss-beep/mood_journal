import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';

class MoodEntryWidget extends StatelessWidget {
  final MoodEntryModel entry;

  const MoodEntryWidget({
    super.key,
    required this.entry,
  });

  String _getDaysAgo(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(date.year, date.month, date.day);
    final difference = today.difference(entryDate).inDays;

    if (difference == 0) return 'TODAY';
    if (difference == 1) return '1 DAY AGO';
    return '$difference DAYS AGO';
  }

  Color _getMoodColor(MoodModel mood) {
    switch (mood) {
      case MoodModel.awesome:
        return Colors.green.shade100;
      case MoodModel.good:
        return Colors.lime.shade100;
      case MoodModel.neutral:
        return Colors.grey.shade200;
      case MoodModel.bad:
        return Colors.orange.shade100;
      case MoodModel.awful:
        return Colors.red.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildCard(),
      ],
    );
  }

  // Заголовок: дата + день недели (лежит прямо на фоне экрана)
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('d').format(entry.date),
                style: journal_date_day,
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat('MMM').format(entry.date).toUpperCase(),
                style: journal_date_month,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE').format(entry.date),
                style: journal_weekday,
              ),
              const SizedBox(height: 4),
              Text(
                _getDaysAgo(entry.date),
                style: journal_days_ago,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Белая карточка: настроение + теги
  Widget _buildCard() {
    final tags = [
      ...entry.activities.map((a) => a.name),
      ...entry.feelings.map((f) => f.name),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _getMoodColor(entry.mood),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    entry.mood.assetsPath,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title.isNotEmpty ? entry.title : entry.mood.label,
                      style: journal_mood_title,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('h:mm a').format(entry.date).toUpperCase(),
                      style: journal_time,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (entry.notes.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              entry.notes.trim(),
              style: journal_notes,
            ),
          ],
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map(_buildTag).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: journal_tag,
      ),
    );
  }
}