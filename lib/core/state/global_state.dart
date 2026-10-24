import 'package:flutter/material.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState extends ChangeNotifier {
  String _userName = "";
  AppThemeModel _selectedTheme = backThemes[0];
  String _userEmail = "";
  bool _isLoaded = false;
  int _currentIndex = 0;

  String get userName => _userName;
  String get userEmail => _userEmail;
  AppThemeModel get selectedTheme => _selectedTheme;
  bool get isLoaded => _isLoaded;
  int get currentIndex => _currentIndex;

  DateTime _selectedTaskDate = DateTime.now();
  DateTime get selectedTaskDate => _selectedTaskDate;

  DateTime _selectedChallengeDate = DateTime.now();
  DateTime get selectedChallengeDate => _selectedChallengeDate;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final savedThemeId = prefs.getString('selected_theme_id');
    if (savedThemeId != null) {
      _selectedTheme = backThemes.firstWhere(
            (theme) => theme.id == savedThemeId,
        orElse: () => backThemes[0],
      );
    }

    _userName = prefs.getString('user_name') ?? "";

    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // Пользователь залогинен: почта и имя берутся из Firebase
      _userEmail = firebaseUser.email ?? "";
      final fbName = firebaseUser.displayName;
      if (fbName != null && fbName.isNotEmpty) {
        _userName = fbName;
      } else if (_userName.isEmpty) {
        _userName = "User";
      }
    } else {
      // Не залогинен: почту с прошлых запусков не восстанавливаем
      _userEmail = "";
    }

    await prefs.remove('user_email'); // чистим старые данные
    await _saveToStorage();

    _isLoaded = true;
    notifyListeners();
  }

  /// Подтянуть имя и почту из Firebase после входа
  Future<void> syncWithFirebaseUser() async {
    // Не трогаем состояние прямо во время построения виджетов
    await Future.microtask(() {});

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final fbName = user.displayName;
    final newEmail = user.email ?? '';
    final newName = (fbName != null && fbName.isNotEmpty)
        ? fbName
        : (_userName.isNotEmpty ? _userName : 'User');

    if (newEmail == _userEmail && newName == _userName) return;

    _userEmail = newEmail;
    _userName = newName;
    notifyListeners();
    await _saveToStorage();
  }

  void setName(String name) {
    _userName = name;
    notifyListeners();
    _saveToStorage();
  }

  void setTheme(AppThemeModel t) {
    _selectedTheme = t;
    notifyListeners();
    _saveToStorage();
  }

  // Почта хранится только в памяти (источник правды — Firebase)
  void setEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void clear() {
    _userName = "";
    _userEmail = "";
    _selectedTheme = backThemes[0];
    notifyListeners();
    _clearStorage();
  }

  // Сохранение в SharedPreferences (почту намеренно не сохраняем)
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _userName);
    await prefs.setString('selected_theme_id', _selectedTheme.id);
  }

  // Очистка хранилища
  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('selected_theme_id');
  }


  /// Открыть экран задания за выбранный день
  void openDailyTask(DateTime date) {
    _selectedTaskDate = date;
    _currentIndex = 6;
    notifyListeners();
  }

  /// Открыть экран челленджа за выбранный день
  void openDailyChallenge(DateTime date) {
    _selectedChallengeDate = date;
    _currentIndex = 7;
    notifyListeners();
  }
}