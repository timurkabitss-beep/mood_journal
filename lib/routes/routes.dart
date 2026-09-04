import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/dashboard_screen.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/features/mood/view/feelings_check_screen.dart';
import 'package:mood_journal/features/mood/view/mood_check_screen.dart';
import 'package:mood_journal/features/mood/view/activity_check_screen.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import '../features/backgr/view/background_choice_screen.dart';
import '../features/hello/view/hello_screen.dart';
import '../features/name/view/name_input_screen.dart';

final routes = {
  '/': (context) => const HelloScreen(),
};

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
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
    else if (settings.name == '/activity_check_screen') {
      final chosenMood = settings.arguments as MoodModel;

      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => ActivityCheckScreen(
          chosenMood: chosenMood,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }
    else if (settings.name == '/activity_check_screen') {
      final chosenMood = settings.arguments as MoodModel;

      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => ActivityCheckScreen(
          chosenMood: chosenMood,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }
    else if (settings.name == '/feelings_check_screen') {

      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => FeelingsCheckScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }
  }
}