import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'package:mood_journal/core/database/hive_initializer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Инициализация Hive

  // Создаем AppState и загружаем сохраненные данные
  final appState = AppState();
  await appState.loadFromStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: basicTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    ),
  );
}