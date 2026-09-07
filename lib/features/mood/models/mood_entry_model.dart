import 'package:hive_flutter/hive_flutter.dart';
import 'activity_model.dart';
import 'mood_model.dart';
import 'feeling_model.dart';

part 'mood_entry_model.g.dart';

@HiveType(typeId: 0)
class MoodEntryModel extends HiveObject{
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final MoodModel mood;

  @HiveField(2)
  final List<ActivityModel> activities;

  @HiveField(3)
  final List<FeelingModel> feelings;
  
  @HiveField(4)
  final String title;

  @HiveField(5)
  final String notes;

  MoodEntryModel(
      {
        required this.date,
        required this.mood,
        required this.activities,
        required this.feelings,
        required this.title,
        required this.notes}
      );

  
}