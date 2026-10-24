import 'package:mood_journal/core/data/mock_challenges.dart';

/// Челлендж для выбранной даты. Один и тот же день даёт один и тот же челлендж.
String getChallengeForDate(DateTime date) {
  final daysSinceEpoch = date.millisecondsSinceEpoch ~/ (1000 * 60 * 60 * 24);
  // сдвиг, чтобы челлендж не совпадал по порядку с заданием дня
  final index = (daysSinceEpoch + 17) % dailyChallenges.length;
  return dailyChallenges[index];
}