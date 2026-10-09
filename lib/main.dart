import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/core/state/quotes_state.dart';
import 'package:mood_journal/firebase_options.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'package:mood_journal/core/database/hive_initializer.dart';
import 'package:provider/provider.dart';

import 'core/database/repositories/quotes_repository.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await init(); // Инициализация Hive

  // Создаем AppState и загружаем сохраненные данные
  final appState = AppState();
  await appState.loadFromStorage();

  final quotesState = QuotesState();
  await quotesState.loadQuotes();
  await QuotesRepository.instance.initLocalQuotes();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
        ChangeNotifierProvider.value(value: quotesState),
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