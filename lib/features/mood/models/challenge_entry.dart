/// Выполненный ежедневный челлендж (обычный Dart-класс, не Hive-модель)
class ChallengeEntry {
  final DateTime date;
  final String challenge;
  final String result;

  const ChallengeEntry({
    required this.date,
    required this.challenge,
    required this.result,
  });
}