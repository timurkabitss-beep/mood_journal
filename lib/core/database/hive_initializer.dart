import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/models.dart';

import '../../features/mood/models/mood_entry_model.dart';
import 'hive_box.dart';

Future<void> init() async{
  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryModelAdapter());
  Hive.registerAdapter(MoodModelAdapter());
  Hive.registerAdapter(ActivityModelAdapter());
  Hive.registerAdapter(FeelingModelAdapter());
  await Hive.openBox<MoodEntryModel>(HiveBoxes.moodJournalEntry);
}