import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:mood_journal/features/mood/models/daily_answer_entry.dart';
import 'package:mood_journal/features/mood/models/challenge_entry.dart';
import '../cloud_sync_service.dart';
import '../hive_box.dart';

class MoodRepository {
  MoodRepository._();
  static final MoodRepository instance = MoodRepository._();

  Box<MoodEntryModel>? _boxInstance;
  Box? _answersBoxInstance; // ответы на ежедневные задания
  Box? _challengesBoxInstance; // результаты ежедневных челленджей
  String? _uid;
  Future<void>? _opening;
  bool _syncing = false;

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

    // Синхронизация с облаком идёт в фоне и не задерживает открытие экрана
    unawaited(_syncWithCloud(uid));
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

  /// Удалить с устройства все локальные данные текущего пользователя
  /// (используется при удалении аккаунта)
  Future<void> deleteLocalData() async {
    final uid = _uid ?? FirebaseAuth.instance.currentUser?.uid;
    await close();
    if (uid == null) return;

    await Hive.deleteBoxFromDisk('${HiveBoxes.moodJournalEntry}_$uid');
    await Hive.deleteBoxFromDisk('dailyAnswers_$uid');
    await Hive.deleteBoxFromDisk('dailyChallenges_$uid');
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
    final key = _dayKey(entry.date);
    await _box.put(key, entry);

    final uid = _uid;
    if (uid != null) CloudSyncService.instance.pushMood(uid, key, entry);
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
    final key = _dayKey(date);
    final data = {
      'date': date.toIso8601String(),
      'task': task,
      'answer': answer,
      'clientUpdatedAt': DateTime.now().toUtc().toIso8601String(),
    };
    await _answersBox.put(key, data);

    final uid = _uid;
    if (uid != null) {
      CloudSyncService.instance.push(uid, CloudSyncService.answersCol, key, data);
    }
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
    final key = _dayKey(date);
    final data = {
      'date': date.toIso8601String(),
      'challenge': challenge,
      'result': result,
      'clientUpdatedAt': DateTime.now().toUtc().toIso8601String(),
    };
    await _challengesBox.put(key, data);

    final uid = _uid;
    if (uid != null) {
      CloudSyncService.instance
          .push(uid, CloudSyncService.challengesCol, key, data);
    }
  }

  /// Для автообновления UI (карточка челленджа на главной)
  ValueListenable<Box> challengesListenable() => _challengesBox.listenable();

  /// Выполненные челленджи за последние N дней (включая сегодня), свежие сверху
  List<ChallengeEntry> getChallengesForLastDays(int days) {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: days - 1));

    final result = <ChallengeEntry>[];
    for (final value in _challengesBox.values) {
      if (value is! Map) continue;
      final date = DateTime.tryParse('${value['date']}');
      if (date == null || date.isBefore(from)) continue;
      result.add(ChallengeEntry(
        date: date,
        challenge: '${value['challenge']}',
        result: '${value['result']}',
      ));
    }
    result.sort((a, b) => b.date.compareTo(a.date));
    return result;
  }

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

  // ----------------------- Синхронизация с Firestore -----------------------

  bool _isActiveFor(String uid) =>
      _uid == uid &&
          (_boxInstance?.isOpen ?? false) &&
          (_answersBoxInstance?.isOpen ?? false) &&
          (_challengesBoxInstance?.isOpen ?? false);

  Future<void> _syncWithCloud(String uid) async {
    if (_syncing) return;
    _syncing = true;

    try {
      final cloud = CloudSyncService.instance;

      // 1. Один раз отправляем то, что уже лежит на устройстве
      if (!await cloud.isInitialUploadDone(uid)) {
        if (!_isActiveFor(uid)) return;

        for (final key in _boxInstance!.keys) {
          final entry = _boxInstance!.get(key);
          if (entry != null) cloud.pushMood(uid, '$key', entry);
        }
        for (final key in _answersBoxInstance!.keys) {
          final value = _answersBoxInstance!.get(key);
          if (value is Map) {
            cloud.push(uid, CloudSyncService.answersCol, '$key',
                Map<String, dynamic>.from(value));
          }
        }
        for (final key in _challengesBoxInstance!.keys) {
          final value = _challengesBoxInstance!.get(key);
          if (value is Map) {
            cloud.push(uid, CloudSyncService.challengesCol, '$key',
                Map<String, dynamic>.from(value));
          }
        }
        await cloud.markInitialUploadDone(uid);
      }

      // 2. Забираем изменения из облака (на новом устройстве это весь журнал)
      await _pullMoods(uid);
      await _pullMaps(
        uid,
        CloudSyncService.answersCol,
            () => _answersBox,
        const ['date', 'task', 'answer'],
      );
      await _pullMaps(
        uid,
        CloudSyncService.challengesCol,
            () => _challengesBox,
        const ['date', 'challenge', 'result'],
      );
    } catch (e) {
      debugPrint('Cloud sync error: $e');
    } finally {
      _syncing = false;
    }
  }

  Future<void> _pullMoods(String uid) async {
    final cloud = CloudSyncService.instance;
    final since = await cloud.lastSync(uid, CloudSyncService.moodsCol);
    final snap = await cloud.fetchChanged(uid, CloudSyncService.moodsCol,
        since: since);
    if (snap == null || !_isActiveFor(uid)) return;

    Timestamp? maxTs;
    for (final doc in snap.docs) {
      // записи, ещё не ушедшие в облако, не трогаем
      if (doc.metadata.hasPendingWrites) continue;

      final data = doc.data();
      final ts = data['updatedAt'];
      if (ts is Timestamp && (maxTs == null || ts.compareTo(maxTs) > 0)) {
        maxTs = ts;
      }

      final entry = cloud.moodFromMap(data);
      if (entry == null) continue;

      // побеждает более свежая запись
      final local = _box.get(doc.id);
      if (local == null || entry.date.isAfter(local.date)) {
        await _box.put(doc.id, entry);
      }
    }
    if (maxTs != null) {
      await cloud.saveLastSync(uid, CloudSyncService.moodsCol, maxTs);
    }
  }

  Future<void> _pullMaps(
      String uid,
      String collection,
      Box Function() boxGetter,
      List<String> fields,
      ) async {
    final cloud = CloudSyncService.instance;
    final since = await cloud.lastSync(uid, collection);
    final snap = await cloud.fetchChanged(uid, collection, since: since);
    if (snap == null || !_isActiveFor(uid)) return;

    Timestamp? maxTs;
    for (final doc in snap.docs) {
      if (doc.metadata.hasPendingWrites) continue;

      final data = doc.data();
      final ts = data['updatedAt'];
      if (ts is Timestamp && (maxTs == null || ts.compareTo(maxTs) > 0)) {
        maxTs = ts;
      }

      final box = boxGetter();
      final local = box.get(doc.id);
      final localStamp = local is Map ? '${local['clientUpdatedAt'] ?? ''}' : '';
      final cloudStamp = '${data['clientUpdatedAt'] ?? ''}';

      // побеждает более свежая версия
      if (local == null || cloudStamp.compareTo(localStamp) > 0) {
        await box.put(doc.id, {
          for (final f in fields) f: '${data[f] ?? ''}',
          'clientUpdatedAt': cloudStamp,
        });
      }
    }
    if (maxTs != null) {
      await cloud.saveLastSync(uid, collection, maxTs);
    }
  }
}