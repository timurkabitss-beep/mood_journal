import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/main_dashboard_screen.dart';
import 'package:mood_journal/features/dashboard/view/secondary_dashboard/first_dashboard_screen.dart';
import 'package:mood_journal/features/entrance/registration/view/registration_screen.dart';
import 'package:mood_journal/features/mood/view/check_in_flow_screen.dart';
import '../features/dashboard/view/secondary_dashboard/second_dashboard_screen.dart';
import 'package:mood_journal/core/widgets/auth_gate.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => const AuthGate(),
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