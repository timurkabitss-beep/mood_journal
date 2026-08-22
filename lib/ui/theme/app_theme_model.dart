import 'package:flutter/material.dart';

class AppThemeModel{
  final String id;
  final List<Color> colors;

  const AppThemeModel({required this.id, required this.colors});
}

final List<AppThemeModel> backThemes = [
  const AppThemeModel(
      id: 'original',
      colors:
      [
        Color.fromARGB(255, 86, 0, 168),
        Color.fromARGB(255, 47, 136, 177)
      ]
  ),

  const AppThemeModel(
    id: 'pink',
    colors: [
      Color(0xFFE94057),
      Color(0xFFF27121),
    ],
  ),
const AppThemeModel(
    id: 'mint',
    colors: [
      Color(0xFF0F2027),
      Color(0xFF203A43),
      Color(0xFF2C5364),

    ],
  ),

  const AppThemeModel(
    id: 'neon_mint',
    colors: [
      Color(0xFF00B4DB),
      Color(0xFF0083B0),
    ],
  ),

  const AppThemeModel(
    id: 'cyber_green',
    colors: [
      Color(0xFF11998E),
      Color(0xFF38EF7D),
    ],
  ),
];