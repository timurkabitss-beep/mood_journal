import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/core/database/repositories/quotes_repository.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import '../../features/dashboard/view/main_dashboard/view/models/quotes_text_model.dart';
import '../../features/mood/models/mood_entry_model.dart';
import 'hive_box.dart';

Future<void> init() async{
  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryModelAdapter());
  Hive.registerAdapter(MoodModelAdapter());
  Hive.registerAdapter(ActivityModelAdapter());
  Hive.registerAdapter(FeelingModelAdapter());
  Hive.registerAdapter(QuotesTextModelAdapter());

  await Hive.openBox<MoodEntryModel>(HiveBoxes.moodJournalEntry);
  await Hive.openBox<QuotesTextModel>(HiveBoxes.quotesEntry);
  await QuotesRepository.instance.initLocalQuotes();
}