import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/feeling_model.dart';
import 'package:mood_journal/features/mood/models/mood_entry_model.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Копия журнала в Firestore (users/{uid}/...).
/// Hive остаётся основным хранилищем для UI, Firestore нужен для
/// резервной копии и восстановления на новом устройстве.
class CloudSyncService {
  CloudSyncService._();
  static final CloudSyncService instance = CloudSyncService._();

  static const String moodsCol = 'moods';
  static const String answersCol = 'dailyAnswers';
  static const String challengesCol = 'challenges';

  CollectionReference<Map<String, dynamic>> _col(String uid, String name) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(name);
  }

  // ----------------------- сериализация -----------------------

  Map<String, dynamic> moodToMap(MoodEntryModel e) => {
    'date': e.date.toIso8601String(),
    'mood': e.mood.name,
    'activities': e.activities.map((a) => a.name).toList(),
    'feelings': e.feelings.map((f) => f.name).toList(),
    'title': e.title,
    'notes': e.notes,
  };

  MoodEntryModel? moodFromMap(Map<String, dynamic> m) {
    final date = DateTime.tryParse('${m['date']}');
    if (date == null) return null;

    MoodModel mood = MoodModel.neutral;
    for (final v in MoodModel.values) {
      if (v.name == m['mood']) mood = v;
    }

    final activities = <ActivityModel>[];
    for (final name in (m['activities'] as List? ?? const [])) {
      for (final v in ActivityModel.values) {
        if (v.name == name) activities.add(v);
      }
    }

    final feelings = <FeelingModel>[];
    for (final name in (m['feelings'] as List? ?? const [])) {
      for (final v in FeelingModel.values) {
        if (v.name == name) feelings.add(v);
      }
    }

    return MoodEntryModel(
      date: date,
      mood: mood,
      activities: activities,
      feelings: feelings,
      title: '${m['title'] ?? ''}',
      notes: '${m['notes'] ?? ''}',
    );
  }

  // ------------------------- отправка -------------------------

  /// Не ждём ответа сервера: без интернета Firestore сам поставит запись
  /// в очередь и отправит позже. Сохранение в приложении от этого не зависит.
  void push(String uid, String collection, String key, Map<String, dynamic> data) {
    try {
      unawaited(
        _col(uid, collection)
            .doc(key)
            .set({...data, 'updatedAt': FieldValue.serverTimestamp()})
            .catchError((Object e) {
          debugPrint('CloudSync push error: $e');
        }),
      );
    } catch (e) {
      debugPrint('CloudSync push error: $e');
    }
  }

  void pushMood(String uid, String key, MoodEntryModel entry) =>
      push(uid, moodsCol, key, moodToMap(entry));

  // ------------------------- загрузка -------------------------

  /// Документы, изменённые после [since] (или все, если since == null)
  Future<QuerySnapshot<Map<String, dynamic>>?> fetchChanged(
      String uid,
      String collection, {
        Timestamp? since,
      }) async {
    try {
      Query<Map<String, dynamic>> query = _col(uid, collection);
      if (since != null) {
        query = query.where('updatedAt', isGreaterThan: since);
      }
      return await query.get().timeout(const Duration(seconds: 20));
    } catch (e) {
      debugPrint('CloudSync fetch error ($collection): $e');
      return null;
    }
  }

  // ---------------- служебные отметки (на пользователя) ----------------

  String _syncKey(String uid, String col) => 'cloud_sync_${uid}_$col';

  Future<Timestamp?> lastSync(String uid, String col) async {
    final prefs = await SharedPreferences.getInstance();
    final ms = prefs.getInt(_syncKey(uid, col));
    return ms == null ? null : Timestamp.fromMillisecondsSinceEpoch(ms);
  }

  Future<void> saveLastSync(String uid, String col, Timestamp ts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_syncKey(uid, col), ts.millisecondsSinceEpoch);
  }

  Future<bool> isInitialUploadDone(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('cloud_initial_upload_$uid') ?? false;
  }

  Future<void> markInitialUploadDone(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cloud_initial_upload_$uid', true);
  }

  // ----------------------- удаление данных -----------------------

  /// Удаляет весь журнал пользователя из облака.
  /// Вызывать ДО удаления аккаунта (после удаления права доступа уже нет).
  Future<void> deleteAllUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    for (final name in [moodsCol, answersCol, challengesCol]) {
      final snap = await _col(uid, name).get();
      var batch = FirebaseFirestore.instance.batch();
      var count = 0;
      for (final doc in snap.docs) {
        batch.delete(doc.reference);
        count++;
        if (count == 400) {
          await batch.commit();
          batch = FirebaseFirestore.instance.batch();
          count = 0;
        }
      }
      if (count > 0) await batch.commit();
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cloud_initial_upload_$uid');
    for (final name in [moodsCol, answersCol, challengesCol]) {
      await prefs.remove(_syncKey(uid, name));
    }
  }
}