import 'package:mood_journal/core/data/mock_tasks.dart';

/// Вопрос дня для выбранной даты. Используется и карточкой, и экраном задания,
/// чтобы они всегда показывали один и тот же текст.
String getTaskForDate(DateTime date) {
  final daysSinceEpoch = date.millisecondsSinceEpoch ~/ (1000 * 60 * 60 * 24);
  final taskIndex = daysSinceEpoch % dailyTasks.length;
  return dailyTasks[taskIndex];
}