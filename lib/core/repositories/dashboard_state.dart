import 'dart:ui';

import 'package:flutter/cupertino.dart';

class DashboardState {
  final String userName;
  final List<Color> themeColors;
  final String firstText;
  final InlineSpan secondText;
  final String targetRoute;

  const DashboardState(
      {
        required this.userName,
        required this.themeColors,
        required this.firstText,
        required this.secondText,
        required this.targetRoute});
}