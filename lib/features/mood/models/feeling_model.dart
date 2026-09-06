
enum FeelingModel {
  happy('assets/svg/feelings_svg/feel_happy.svg', 'Happy'),
  down('assets/svg/feelings_svg/feel_down.svg', 'Down'),
  bored('assets/svg/feelings_svg/feel_bored.svg','Bored'),
  angry('assets/svg/feelings_svg/feel_angry.svg', 'Angry'),
  blessed('assets/svg/feelings_svg/feel_blessed.svg', 'Blessed'),
  inspired('assets/svg/feelings_svg/feel_inspired.svg', 'Inspired'),
  anxious('assets/svg/feelings_svg/feel_anxious.svg', 'Anxious'),
  proud('assets/svg/feelings_svg/feel_proud.svg', 'Proud'),
  focused('assets/svg/feelings_svg/feel_focused.svg', 'Focused'),
  chill('assets/svg/feelings_svg/feel_chill.svg', 'Chill'),
  confused('assets/svg/feelings_svg/feel_confused.svg', 'Confused'),
  awkward('assets/svg/feelings_svg/feel_awkward.svg', 'Awkward'),
  good('assets/svg/feelings_svg/feel_good.svg', 'Good');

  final String assetPath;
  final String label;

  const FeelingModel(this.assetPath, this.label);
}
