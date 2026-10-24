import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:mood_journal/features/mood/models/daily_answer_entry.dart';
import '../hive_box.dart';

class MoodRepository {
  MoodRepository._();
  static final MoodRepository instance = MoodRepository._();

  Box<MoodEntryModel>? _boxInstance;
  Box? _answersBoxInstance; // ответы на ежедневные задания
  Box? _challengesBoxInstance; // результаты ежедневных челленджей
  String? _uid;
  Future<void>? _opening;

  Box<MoodEntryModel> get _box {
    final box = _boxInstance;
    if (box == null || !box.isOpen) {
      throw StateError(
        'Mood box is not opened. Call MoodRepository.instance.openForCurrentUser() after login.',
      );
    }
    return box;
  }

  Box get _answersBox {
    final box = _answersBoxInstance;
    if (box == null || !box.isOpen) {
      throw StateError(
        'Daily answers box is not opened. Call MoodRepository.instance.openForCurrentUser() after login.',
      );
    }
    return box;
  }

  Box get _challengesBox {
    final box = _challengesBoxInstance;
    if (box == null || !box.isOpen) {
      throw StateError(
        'Challenges box is not opened. Call MoodRepository.instance.openForCurrentUser() after login.',
      );
    }
    return box;
  }

  /// Открыть боксы текущего пользователя (у каждого uid свои).
  /// Вызывать: при старте приложения, после входа и после регистрации.
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

    if (_uid == uid &&
        (_boxInstance?.isOpen ?? false) &&
        (_answersBoxInstance?.isOpen ?? false) &&
        (_challengesBoxInstance?.isOpen ?? false)) {
      return;
    }

    await close();
    _boxInstance = await Hive.openBox<MoodEntryModel>(
      '${HiveBoxes.moodJournalEntry}_$uid',
    );
    _answersBoxInstance = await Hive.openBox('dailyAnswers_$uid');
    _challengesBoxInstance = await Hive.openBox('dailyChallenges_$uid');
    _uid = uid;
  }

  /// Закрыть боксы. Вызывать при выходе из аккаунта (до signOut).
  /// Данные пользователя остаются на диске и вернутся при следующем входе.
  Future<void> close() async {
    if (_boxInstance?.isOpen ?? false) {
      await _boxInstance!.close();
    }
    if (_answersBoxInstance?.isOpen ?? false) {
      await _answersBoxInstance!.close();
    }
    if (_challengesBoxInstance?.isOpen ?? false) {
      await _challengesBoxInstance!.close();
    }
    _boxInstance = null;
    _answersBoxInstance = null;
    _challengesBoxInstance = null;
    _uid = null;
  }

  /// Для автообновления UI при изменениях
  ValueListenable<Box<MoodEntryModel>> listenable() => _box.listenable();

  String _dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.day.toString().padLeft(2, '0')}';

  // ---------------------- Записи настроений ----------------------

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

  // ------------------ Ответы на ежедневные задания ------------------

  /// Ответ за выбранный день (или null, если ещё не отвечали)
  String? getDailyAnswer(DateTime date) {
    final data = _answersBox.get(_dayKey(date));
    if (data is Map) {
      return data['answer'] as String?;
    }
    return null;
  }

  /// Задание за день считается выполненным, если ответ сохранён
  bool isDailyTaskCompleted(DateTime date) {
    final answer = getDailyAnswer(date);
    return answer != null && answer.trim().isNotEmpty;
  }

  /// Для автообновления UI (например, карточки задания) при сохранении ответа
  ValueListenable<Box> dailyAnswersListenable() => _answersBox.listenable();

  /// Сохранить или обновить ответ за день
  Future<void> saveDailyAnswer({
    required DateTime date,
    required String task,
    required String answer,
  }) async {
    await _answersBox.put(_dayKey(date), {
      'date': date.toIso8601String(),
      'task': task,
      'answer': answer,
    });
  }

  /// Ответы на задания за последние N дней (включая сегодня), свежие сверху
  List<DailyAnswerEntry> getDailyAnswersForLastDays(int days) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: days - 1));

    final result = <DailyAnswerEntry>[];
    for (final value in _answersBox.values) {
      if (value is! Map) continue;
      final date = DateTime.tryParse('${value['date']}');
      if (date == null || date.isBefore(from)) continue;
      result.add(DailyAnswerEntry(
        date: date,
        task: '${value['task']}',
        answer: '${value['answer']}',
      ));
    }
    result.sort((a, b) => b.date.compareTo(a.date));
    return result;
  }

  /// Все ответы (свежие сверху). Пригодится для AI-анализа.
  List<Map<String, String>> getAllDailyAnswers() {
    final result = <Map<String, String>>[];
    for (final value in _answersBox.values) {
      if (value is Map) {
        result.add({
          'date': '${value['date']}',
          'task': '${value['task']}',
          'answer': '${value['answer']}',
        });
      }
    }
    result.sort((a, b) => b['date']!.compareTo(a['date']!));
    return result;
  }

  // ---------------------- Ежедневные челленджи ----------------------

  /// Отчёт о челлендже за день (или null, если ещё не выполнен)
  String? getChallengeResult(DateTime date) {
    final data = _challengesBox.get(_dayKey(date));
    if (data is Map) {
      return data['result'] as String?;
    }
    return null;
  }

  /// Челлендж считается выполненным, если сохранён непустой отчёт
  bool isChallengeCompleted(DateTime date) {
    final result = getChallengeResult(date);
    return result != null && result.trim().isNotEmpty;
  }

  Future<void> saveChallengeResult({
    required DateTime date,
    required String challenge,
    required String result,
  }) async {
    await _challengesBox.put(_dayKey(date), {
      'date': date.toIso8601String(),
      'challenge': challenge,
      'result': result,
    });
  }

  /// Для автообновления UI (карточка челленджа на главной)
  ValueListenable<Box> challengesListenable() => _challengesBox.listenable();

  /// Все отчёты о челленджах (свежие сверху). Пригодится для AI-анализа.
  List<Map<String, String>> getAllChallengeResults() {
    final result = <Map<String, String>>[];
    for (final value in _challengesBox.values) {
      if (value is Map) {
        result.add({
          'date': '${value['date']}',
          'challenge': '${value['challenge']}',
          'result': '${value['result']}',
        });
      }
    }
    result.sort((a, b) => b['date']!.compareTo(a['date']!));
    return result;
  }
}