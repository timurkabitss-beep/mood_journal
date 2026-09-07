import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'mood_model.g.dart';

@HiveType(typeId: 1)
enum MoodModel {
  @HiveField(0)
  awful('assets/svg/mood_svg/mood_awful.svg', 'Awful'),
  @HiveField(1)
  bad('assets/svg/mood_svg/mood_bad.svg', 'Bad'),
  @HiveField(2)
  neutral('assets/svg/mood_svg/mood_neutral.svg', 'Neutral'),
  @HiveField(3)
  good('assets/svg/mood_svg/mood_good.svg', 'Good'),
  @HiveField(4)
  awesome('assets/svg/mood_svg/mood_awesome.svg', 'Awesome');


  final String assetsPath;
  final String label;

  const MoodModel(this.assetsPath, this.label);
}