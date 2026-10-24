import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_journal/core/database/repositories/mood_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';import 'package:mood_journal/features/welcome/view/welcome_screen.dart';
import 'package:provider/provider.dart';

import '../../features/dashboard/view/main_dashboard/view/screens/main_dashboard_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();
    final currentTheme = appState.selectedTheme;

    Widget loader() {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: currentTheme.colors,
            ),
          ),
          child: Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2.5,
              strokeCap: StrokeCap.round,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      );
    }

    // StreamBuilder слушает изменения состояния авторизации в реальном времени
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Пока Firebase проверяет состояние (первая загрузка)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loader();
        }

        // Пользователь авторизован: сначала открываем его бокс с записями,
        // и только потом показываем главный экран
        if (snapshot.hasData) {
          return FutureBuilder<List<void>>(
            // Перед главным экраном открываем бокс пользователя
            // и подтягиваем его имя и почту из Firebase
            future: Future.wait([
              MoodRepository.instance.openForCurrentUser(),
              appState.syncWithFirebaseUser(),
            ]),
            builder: (context, boxSnapshot) {
              if (boxSnapshot.connectionState != ConnectionState.done) {
                return loader();
              }
              return MainDashboardScreen();
            },
          );
        }

        // Пользователь не авторизован: бокс закрыт
        return WelcomeScreen();
      },
    );
  }
}