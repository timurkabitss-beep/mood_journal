import 'package:flutter/material.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _userName = "";
  AppThemeModel _selectedTheme = backThemes[0];
  String _userEmail = "";
  bool _isLoaded = false;

  String get userName => _userName;
  String get userEmail => _userEmail;
  AppThemeModel get selectedTheme => _selectedTheme;
  bool get isLoaded => _isLoaded;

  // Загрузка данных из хранилища
  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    _userName = prefs.getString('user_name') ?? "";
    _userEmail = prefs.getString('user_email') ?? "";

    final savedThemeId = prefs.getString('selected_theme_id');
    if (savedThemeId != null) {
      _selectedTheme = backThemes.firstWhere(
            (theme) => theme.id == savedThemeId,
        orElse: () => backThemes[0],
      );
    }

    _isLoaded = true;
    notifyListeners();
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

  void setEmail(String email) {
    _userEmail = email;
    notifyListeners();
    _saveToStorage();
  }

  void clear() {
    _userName = "";
    _userEmail = "";
    _selectedTheme = backThemes[0];
    notifyListeners();
    _clearStorage();
  }

  // Сохранение в SharedPreferences
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _userName);
    await prefs.setString('user_email', _userEmail);
    await prefs.setString('selected_theme_id', _selectedTheme.id);
  }

  // Очистка хранилища
  Future<void> _clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('selected_theme_id');
  }
}