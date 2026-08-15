import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/mood_select_screen.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/mood': (context) => const MoodSelectScreen(),
      },
    ),
  );
}
