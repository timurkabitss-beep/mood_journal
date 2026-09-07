import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part 'feeling_model.g.dart';

@HiveType(typeId: 3)
enum FeelingModel {
  @HiveField(0)
  happy('assets/svg/feelings_svg/feel_happy.svg', 'Happy'),
  @HiveField(1)
  down('assets/svg/feelings_svg/feel_down.svg', 'Down'),
  @HiveField(2)
  bored('assets/svg/feelings_svg/feel_bored.svg','Bored'),
  @HiveField(3)
  angry('assets/svg/feelings_svg/feel_angry.svg', 'Angry'),
  @HiveField(4)
  blessed('assets/svg/feelings_svg/feel_blessed.svg', 'Blessed'),
  @HiveField(5)
  inspired('assets/svg/feelings_svg/feel_inspired.svg', 'Inspired'),
  @HiveField(6)
  anxious('assets/svg/feelings_svg/feel_anxious.svg', 'Anxious'),
  @HiveField(7)
  proud('assets/svg/feelings_svg/feel_proud.svg', 'Proud'),
  @HiveField(8)
  focused('assets/svg/feelings_svg/feel_focused.svg', 'Focused'),
  @HiveField(9)
  chill('assets/svg/feelings_svg/feel_chill.svg', 'Chill'),
  @HiveField(10)
  confused('assets/svg/feelings_svg/feel_confused.svg', 'Confused'),
  @HiveField(11)
  awkward('assets/svg/feelings_svg/feel_awkward.svg', 'Awkward'),
  @HiveField(12)
  good('assets/svg/feelings_svg/feel_good.svg', 'Good');

  final String assetPath;
  final String label;

  const FeelingModel(this.assetPath, this.label);
}
