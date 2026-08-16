import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/mood_select_screen.dart';
import 'screens/name_input_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme:
      ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        elevatedButtonTheme:
        ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(220, 60),
            backgroundColor: Colors.white,
            foregroundColor: const Color.fromARGB(255, 47, 136, 177),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )
        )
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        '/mood': (context) => const MoodSelectScreen(),
        '/name_input': (context) => const NameInputScreen(),
      },
    ),
  );
}
