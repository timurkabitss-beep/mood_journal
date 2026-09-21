import "package:flutter/material.dart";
import 'package:mood_journal/core/state/global_state.dart';
import "package:mood_journal/features/welcome/view/steps/background_choice_step.dart";
import "package:mood_journal/features/welcome/view/steps/hello_step.dart";
import "package:mood_journal/features/welcome/view/steps/login_step.dart";
import "package:mood_journal/features/welcome/view/steps/name_input_step.dart";
import "package:mood_journal/ui/backgroundtheme/gradient_background.dart";
import "package:provider/provider.dart";

import "../../../core/data/auth_repository.dart";


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isFirstLaunch = true;
  bool _isChecking = true;


  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkIfRegistered();
  }


  Future<void> _checkIfRegistered() async {
    final authRepo = AuthRepository();
    final isRegistered = await authRepo.isUserRegistered();

    if (mounted) {
      setState(() {
        _isFirstLaunch = !isRegistered; // Если зарегистрирован, то это НЕ первый запуск
        _isChecking = false;
      });
    }
  }

  void _moveToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    final onboardProvider = context.watch<AppState>();
    final currentTheme = onboardProvider.selectedTheme;
    // Пока проверяем, показываем простой индикатор загрузки
    if (_isChecking) {
      return Scaffold(
        body: GradientBackground(
          colors: currentTheme.colors,
          child: const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2.5,
              strokeCap: StrokeCap.round,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: GradientBackground(
        colors: currentTheme.colors,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  if (_isFirstLaunch) ...[
                    HelloStep(
                      onNext: _moveToNextPage,
                      onHaveAccount: () {
                        setState(() {
                          _isFirstLaunch = false;
                        });
                      },
                    ),
                    NameInputStep(onNext: _moveToNextPage),
                    BackgroundChoiceStep(),
                  ] else ...[
                    LoginStep(
                      onLoginSuccess: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/main_dashboard_screen',
                              (route) => false,
                        );
                      },
                      onBack: () {
                        setState(() {
                          _isFirstLaunch = true;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),

            if (_currentStep > 0 && _isFirstLaunch)
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white70),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
