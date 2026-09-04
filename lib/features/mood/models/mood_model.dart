enum MoodModel {
  awful('assets/svg/mood_svg/mood_awful.svg', 'Awful'),
  bad('assets/svg/mood_svg/mood_bad.svg', 'Bad'),
  neutral('assets/svg/mood_svg/mood_neutral.svg', 'Neutral'),
  good('assets/svg/mood_svg/mood_good.svg', 'Good'),
  awesome('assets/svg/mood_svg/mood_awesome.svg', 'Awesome');

  final String assetsPath;
  final String label;

  const MoodModel(this.assetsPath, this.label);
}