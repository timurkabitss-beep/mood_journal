import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/dashboard_screen.dart';
import 'package:mood_journal/features/mood/view/mood_check_screen.dart';
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
      onGenerateRoute: (settings) {
        if (settings.name == '/name_input'){
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const NameInputScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child,);
              },
            transitionDuration: const Duration(milliseconds: 400)
          );
        }
        else if(settings.name == '/background'){
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const BackgroundChoiceScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child,);
              },
              transitionDuration: const Duration(milliseconds: 400)
          );
        }
        else if (settings.name == '/dashboard') {
          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                  opacity: animation,
                  child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          );
        }
        else if (settings.name == '/mood_screen') {
          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => const MoodCheckScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          );
        }

      },
    ),
  );
}
