import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/view.dart';
import 'package:mood_journal/features/mood/models/feelings_screen_arguments.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/features/mood/view/view.dart';
import '../features/backgr/view/view.dart';
import '../features/hello/view/view.dart';
import '../features/name/view/view.dart';

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
      final args = settings.arguments as FeelingsScreenArguments;
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => FeelingsCheckScreen(
          chosenMood: args.mood, chosenActivities: args.activities,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }
    else if (settings.name == '/mood_summary_screen') {

      final entryModel = settings.arguments as MoodEntryModel;

      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => MoodSummaryScreen(
          entryModel: entryModel,
        ),
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