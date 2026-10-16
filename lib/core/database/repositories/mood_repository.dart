import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import '../hive_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MoodRepository {
  MoodRepository._();
  static final MoodRepository instance = MoodRepository._();

  Box<MoodEntryModel> get _box => Hive.box<MoodEntryModel>(HiveBoxes.moodJournalEntry);

  ValueListenable<Box<MoodEntryModel>> listenable() => _box.listenable();

  /// Записи за последние N дней (включая сегодня), свежие сверху
  List<MoodEntryModel> getEntriesForLastDays(int days) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: days - 1));

    return getAllEntries().where((e) => !e.date.isBefore(from)).toList();
  }
  /// Сохранить новую запись или обновить существующую за этот же день
  Future<void> saveOrUpdateEntry(MoodEntryModel entry) async {
    // 1. Нормализуем дату (убираем часы, минуты, секунды), чтобы сравнивать только дни
    final targetDate = DateTime(entry.date.year, entry.date.month, entry.date.day);

    dynamic existingKey;

    // 2. Ищем, есть ли уже запись с такой же датой
    for (var key in _box.keys) {
      final existingEntry = _box.get(key);

      // ДОБАВЛЕНА ПРОВЕРКА: если запись существует
      if (existingEntry != null) {
        final entryDate = DateTime(
            existingEntry.date.year,
            existingEntry.date.month,
            existingEntry.date.day
        );

        if (entryDate.isAtSameMomentAs(targetDate)) {
          existingKey = key;
          break; // Нашли запись за этот день, выходим из цикла
        }
      }
    }

    // 3. Если запись за сегодня уже есть — обновляем её (перезаписываем)
    if (existingKey != null) {
      await _box.put(existingKey, entry);
    } else {
      // 4. Если записи нет — добавляем новую
      await _box.add(entry);
    }
  }

  /// Все записи (свежие сверху)
  List<MoodEntryModel> getAllEntries() {
    return _box.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Получить количество записей (теперь это точно количество уникальных дней!)
  int getEntriesCount() {
    return _box.length;
  }

  /// Получить последние N записей
  List<MoodEntryModel> getRecentEntries(int count) {
    return getAllEntries().take(count).toList();
  }

  /// Удалить запись по ключу
  Future<void> deleteEntry(dynamic key) async {
    await _box.delete(key);
  }
}