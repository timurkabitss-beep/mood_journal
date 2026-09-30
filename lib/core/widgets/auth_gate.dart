import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/main_dashboard_screen.dart';
import 'package:mood_journal/features/welcome/view/welcome_screen.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.read<AppState>().selectedTheme;

    // StreamBuilder слушает изменения состояния авторизации в реальном времени
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Пока Firebase проверяет состояние (первая загрузка)
        if (snapshot.connectionState == ConnectionState.waiting) {
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

        // Если пользователь авторизован (snapshot.hasData == true)
        if (snapshot.hasData) {
          return  MainDashboardScreen();
        }
        // Если пользователь не авторизован
        return  WelcomeScreen();
      },
    );
  }
}