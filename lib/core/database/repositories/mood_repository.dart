import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import '../hive_box.dart';

class MoodRepository {
  MoodRepository._();
  static final MoodRepository instance = MoodRepository._();

  Box<MoodEntryModel>? _boxInstance;
  String? _uid;

  Box<MoodEntryModel> get _box {
    final box = _boxInstance;
    if (box == null || !box.isOpen) {
      throw StateError(
        'Mood box is not opened. Call MoodRepository.instance.openForCurrentUser() after login.',
      );
    }
    return box;
  }

  /// Открыть бокс текущего пользователя (у каждого uid свой бокс).
  /// Вызывать: при старте приложения, после входа и после регистрации.
  Future<void>? _opening;

  Future<void> openForCurrentUser() {
    // если открытие уже идёт, все вызывающие ждут один и тот же процесс
    return _opening ??= _open().whenComplete(() => _opening = null);
  }

  Future<void> _open() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      await close();
      return;
    }

    if (_uid == uid && (_boxInstance?.isOpen ?? false)) return;

    await close();
    _boxInstance = await Hive.openBox<MoodEntryModel>(
      '${HiveBoxes.moodJournalEntry}_$uid',
    );
    _uid = uid;
  }

  /// Закрыть бокс. Вызывать при выходе из аккаунта (до signOut).
  /// Данные пользователя остаются на диске и вернутся при следующем входе.
  Future<void> close() async {
    if (_boxInstance?.isOpen ?? false) {
      await _boxInstance!.close();
    }
    _boxInstance = null;
    _uid = null;
  }

  /// Для автообновления UI при изменениях
  ValueListenable<Box<MoodEntryModel>> listenable() => _box.listenable();

  String _dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.day.toString().padLeft(2, '0')}';

  /// Сохранить запись или обновить существующую за этот же день
  Future<void> saveOrUpdateEntry(MoodEntryModel entry) async {
    await _box.put(_dayKey(entry.date), entry);
  }

  /// Все записи (свежие сверху)
  List<MoodEntryModel> getAllEntries() {
    return _box.values.toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  /// Записи за последние N дней (включая сегодня), свежие сверху
  List<MoodEntryModel> getEntriesForLastDays(int days) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: days - 1));

    return getAllEntries().where((e) => !e.date.isBefore(from)).toList();
  }

  int getEntriesCount() => _box.length;

  List<MoodEntryModel> getRecentEntries(int count) {
    return getAllEntries().take(count).toList();
  }

  Future<void> deleteEntry(dynamic key) async {
    await _box.delete(key);
  }
}