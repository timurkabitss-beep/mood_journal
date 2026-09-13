import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'package:mood_journal/core/database/hive_initializer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: basicTheme,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    ),
  );
}
