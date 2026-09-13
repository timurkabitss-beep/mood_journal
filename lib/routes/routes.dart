import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/view.dart';
import 'package:mood_journal/features/mood/models/feelings_screen_arguments.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/features/mood/view/check_in_flow_screen.dart';
import 'package:mood_journal/features/mood/view/view.dart';
import 'package:mood_journal/features/welcome/view/welcome_screen.dart';



class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(), // Твой диспетчер шагов онбординга
      );
    }

    else if (settings.name == '/dashboard') {
      return PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      );
    }
    else if (settings.name == '/check_in_flow_screen') {
      return PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const CheckInFlowScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      );
    }



  }
}