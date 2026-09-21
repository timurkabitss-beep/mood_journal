import 'package:flutter/material.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';

class AppState extends ChangeNotifier{

  String _userName = "";
  AppThemeModel _selectedTheme = backThemes[0];
  String _userEmail = "";

  String get userName => _userName;
  String get userEmail => _userEmail;
  AppThemeModel get selectedTheme => _selectedTheme;

  void setName(String name){
    _userName = name;
    notifyListeners();
  }
  void setTheme(AppThemeModel t){
    _selectedTheme = t;
    notifyListeners();
  }

  void setEmail(String email){
    _userEmail = email;
    notifyListeners();
  }

  void clear(){
    _userName = "";
    _userEmail = "";
    notifyListeners();
  }
}