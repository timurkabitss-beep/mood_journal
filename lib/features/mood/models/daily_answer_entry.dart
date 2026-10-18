/// Ответ на ежедневное задание (обычный Dart-класс, не Hive-модель)
class DailyAnswerEntry {
  final DateTime date;
  final String task;
  final String answer;

  const DailyAnswerEntry({
    required this.date,
    required this.task,
    required this.answer,
  });
}