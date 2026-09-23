import 'package:flutter/material.dart';
import 'package:mood_journal/core/data/repositories/auth_repository.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/main_dashboard_screen.dart';
import 'package:mood_journal/features/welcome/view/welcome_screen.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isChecking = true;
  bool _isAuthenticated = false;

  Future<void> _checkAuthStatus()async{
    final repo = AuthRepository();
    final isRegistered = await repo.isUserRegistered();

    if (mounted){
      setState(() {
        _isChecking = false;
        _isAuthenticated = isRegistered;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    _checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    if(_isChecking){
      return const Scaffold(
        body: GradientBackground(
            child: Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2.5,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
        )
      );
    }
    if(_isAuthenticated){
      return const MainDashboardScreen();
    }
    return const WelcomeScreen();
  }
}
