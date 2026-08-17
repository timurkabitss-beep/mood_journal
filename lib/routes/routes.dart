import 'package:flutter/material.dart';
import '../features/home/view/home_screen.dart';
import '../features/mood/view/mood_select_screen.dart';

final routes = {
  '/': (context) => const HomeScreen(),
  '/mood': (context) => const MoodSelectScreen(),
};