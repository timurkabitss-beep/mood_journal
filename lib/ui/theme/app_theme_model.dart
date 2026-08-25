import 'package:flutter/material.dart';

class AppThemeModel{
  final String id;
  final List<Color> colors;

  const AppThemeModel({required this.id, required this.colors});
}
final List<AppThemeModel> backThemes = [
  // Плотный черничный и приглушенный сине-лиловый
  const AppThemeModel(
      id: 'velvet_dusk',
      colors: [
        Color(0xFF4A5568),
        Color(0xFF6366F1),
        Color(0xFF5B21B6),
      ]
  ),

  const AppThemeModel(
    id: 'lemon_mousse',
    colors: [
      Color(0xFFDCAE1D), // Плотный лимонный крем (дает контраст белому тексту)
      Color(0xFFEAA97E), // Нежный персиковый сорбет
      Color(0xFFAB87FF), // Мягкий черничный йогурт для красивого перелива
    ],
  ),

  const AppThemeModel(
    id: 'purpur',
    colors: [
      Color(0xDF9D6AD3),
      Color(0xFFD38787),
      Color(0xFFC6769A),
    ],
  ),

  const AppThemeModel(
    id: 'deep_sage',
    colors: [
      Color(0xFF2E6551),
      Color(0xFF1E463E),
      Color(0xFF4D7C0F),
    ],
  ),

  const AppThemeModel(
    id: 'ocean_mist',
    colors: [
      Color(0xFF0F766E),
      Color(0xFF1E3A8A),
      Color(0xFF3B82F6),
    ],
  ),
];
