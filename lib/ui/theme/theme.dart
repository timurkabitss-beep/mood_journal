import 'package:flutter/material.dart';

final basicTheme =  ThemeData(
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
);