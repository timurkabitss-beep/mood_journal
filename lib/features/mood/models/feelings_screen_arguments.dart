import 'activity_model.dart';
import 'mood_model.dart';

class FeelingsScreenArguments {
  final MoodModel mood;
  final List<ActivityModel> activities;

  FeelingsScreenArguments({required this.mood, required this.activities});
}
