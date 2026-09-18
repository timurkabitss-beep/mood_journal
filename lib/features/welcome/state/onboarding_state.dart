import 'package:flutter/material.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';

class OnboardingState extends ChangeNotifier{
  String userName = "";
  AppThemeModel selectedTheme = backThemes[0];

  void setName(String name){
    userName = name;
    notifyListeners();
  }
  void setTheme(AppThemeModel t){
    selectedTheme = t;
    notifyListeners();
  }
}