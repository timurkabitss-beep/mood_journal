import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';


void main() async {
  await Hive.initFlutter();
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
