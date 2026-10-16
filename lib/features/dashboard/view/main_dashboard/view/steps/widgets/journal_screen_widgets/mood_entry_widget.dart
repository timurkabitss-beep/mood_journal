import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';

class _C {
  static const dateBox = Color(0xFFE6ECF4); // плашка с датой
  static const tagBg = Color(0xFFF1F4F9); // фон тега
  static const shadow = Color(0xFF9FB3CC); // оттенок тени
}

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
        return const Color(0xFFE3F6EA);
      case MoodModel.good:
        return const Color(0xFFFFEDEE);
      case MoodModel.neutral:
        return const Color(0xFFEDF1F7);
      case MoodModel.bad:
        return const Color(0xFFFFF1E2);
      case MoodModel.awful:
        return const Color(0xFFFFE3E3);
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
            color: _C.dateBox,
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
            color: _C.shadow.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
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
                      color: _C.shadow.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
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
        color: _C.tagBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: journal_tag,
      ),
    );
  }
}