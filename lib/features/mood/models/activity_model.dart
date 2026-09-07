import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'activity_model.g.dart';

@HiveType(typeId: 2)
enum ActivityModel {
  @HiveField(0)
  relationship('assets/svg/activity_svg/relationship.svg', 'Relationship'),
  @HiveField(1)
  friends('assets/svg/activity_svg/friends.svg', 'Friends'),
  @HiveField(2)
  travel('assets/svg/activity_svg/travel.svg', 'Travel'),
  @HiveField(3)
  food('assets/svg/activity_svg/food.svg', 'Food'),
  @HiveField(4)
  sport('assets/svg/activity_svg/sport.svg', 'Sport'),
  @HiveField(5)
  health('assets/svg/activity_svg/health.svg', 'Health'),
  @HiveField(6)
  family('assets/svg/activity_svg/family.svg', 'Family'),
  @HiveField(7)
  work('assets/svg/activity_svg/work.svg', 'Work'),
  @HiveField(8)
  school('assets/svg/activity_svg/school.svg', 'School'),
  @HiveField(9)
  camping('assets/svg/activity_svg/camping.svg', 'Camping'),
  @HiveField(10)
  gaming('assets/svg/activity_svg/gaming.svg', 'Gaming'),
  @HiveField(11)
  pets('assets/svg/activity_svg/pets.svg', 'Pets'),
  @HiveField(12)
  music('assets/svg/activity_svg/music.svg', 'Music'),
  @HiveField(13)
  sleep('assets/svg/activity_svg/sleep.svg', 'Sleep'),
  @HiveField(14)
  weather('assets/svg/activity_svg/weather.svg', 'Weather');



  final String assetPath;
  final String label;

  const ActivityModel(this.assetPath, this.label);
}
