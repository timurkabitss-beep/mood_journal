import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard_screen.dart';
import 'package:mood_journal/features/dashboard/view/view.dart';
import 'package:mood_journal/features/entrance/registration/view/registration_screen.dart';
import 'package:mood_journal/features/mood/view/check_in_flow_screen.dart';
import 'package:mood_journal/features/welcome/view/welcome_screen.dart';
import '../features/dashboard/view/second_dashboard_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(), // Твой диспетчер шагов онбординга
      );
    }
    else if (settings.name == '/first_dashboard') {
      return PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const FirstDashboardScreen(),
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
    else if (settings.name == '/second_dashboard') {
      return PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const SecondDashboardScreen(),
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

    else if (settings.name == '/registration_screen') {
      return PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const RegistrationScreen(),
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
    else if (settings.name == '/main_dashboard_screen') {
      return PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const MainDashboardScreen(),
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