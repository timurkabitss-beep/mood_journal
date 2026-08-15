enum MoodType {
  excellent,
  good,
  normal,
  bad,
  terrible,
}

class MoodRecord {
  final String idMood;
  final DateTime createdAt;
  final String? textRec;
  final MoodType mood;

  const MoodRecord({required this.idMood,required this.createdAt,required this.textRec,required this.mood});
}

