
enum FeelingModel {
  //Todo:
   // ЗАГЛУШКИ, СДЕЛАТЬ НОВЫЕ В ФИГМЕ
  relationship('assets/svg/activity_svg/relationship.svg', 'Relationship'),
  friends('assets/svg/activity_svg/friends.svg', 'Friends'),
  travel('assets/svg/activity_svg/travel.svg', 'Travel'),
  food('assets/svg/activity_svg/food.svg', 'Food'),
  sport('assets/svg/activity_svg/sport.svg', 'Sport'),
  health('assets/svg/activity_svg/health.svg', 'Health'),
  family('assets/svg/activity_svg/family.svg', 'Family'),
  work('assets/svg/activity_svg/work.svg', 'Work'),
  school('assets/svg/activity_svg/school.svg', 'School'),
  camping('assets/svg/activity_svg/camping.svg', 'Camping'),
  gaming('assets/svg/activity_svg/gaming.svg', 'Gaming'),
  pets('assets/svg/activity_svg/pets.svg', 'Pets'),
  music('assets/svg/activity_svg/music.svg', 'Music'),
  sleep('assets/svg/activity_svg/sleep.svg', 'Sleep'),
  weather('assets/svg/activity_svg/weather.svg', 'Weather');
  //Todo:
  // ЗАГЛУШКИ, СДЕЛАТЬ НОВЫЕ В ФИГМЕ


  final String assetPath;
  final String label;

  const FeelingModel(this.assetPath, this.label);
}
