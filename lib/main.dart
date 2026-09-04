import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/dashboard_screen.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/features/mood/view/mood_check_screen.dart';
import 'package:mood_journal/features/mood/view/activity_check_screen.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'features/name/view/view.dart';
import 'features/backgr/view/view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: basicTheme,
      routes: routes,
      onGenerateRoute: AppRoutes.onGenerateRoute
    ),
  );
}
