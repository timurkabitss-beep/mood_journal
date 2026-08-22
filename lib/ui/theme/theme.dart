import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final basicTheme =  ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: GoogleFonts.comfortaa().fontFamily,
    elevatedButtonTheme:
    ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(220, 60),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        )
    )
);