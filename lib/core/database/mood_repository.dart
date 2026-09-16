import 'package:hive/hive.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';

import 'hive_box.dart';

/// Прослойка между UI и Hive.
/// Виджеты не знают про Hive — только про этот класс.
class MoodRepository {
  MoodRepository._();
  static final MoodRepository instance = MoodRepository._();

  Box<MoodEntryModel> get _box =>
      Hive.box<MoodEntryModel>(HiveBoxes.moodJournalEntry);

  /// Сохранить новую запись дневника
  Future<void> saveEntry(MoodEntryModel entry) async {
    await _box.add(entry);
  }

  /// Все записи (для будущего экрана истории)
  List<MoodEntryModel> getAllEntries() {
    return _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // свежие сверху
  }

  /// Удалить запись по ключу
  Future<void> deleteEntry(dynamic key) async {
    await _box.delete(key);
  }
}