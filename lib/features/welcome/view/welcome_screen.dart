import "package:flutter/material.dart";
import 'package:mood_journal/core/state/global_state.dart';
import "package:mood_journal/features/welcome/view/steps/background_choice_step.dart";
import "package:mood_journal/features/welcome/view/steps/hello_step.dart";
import "package:mood_journal/features/welcome/view/steps/login_step.dart";
import "package:mood_journal/features/welcome/view/steps/name_input_step.dart";
import "package:mood_journal/ui/backgroundtheme/gradient_background.dart";
import "package:provider/provider.dart";

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final PageController _pageController = PageController(initialPage: 1);
  int _currentStep = 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;

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
                  LoginStep(
                    onLoginSuccess: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/main_dashboard_screen',
                            (route) => false,
                      );
                    },
                    onBack: () {

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  HelloStep(
                    onNext: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                    onHaveAccount: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  NameInputStep(
                    onNext: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  BackgroundChoiceStep(),
                ],
              ),
            ),
            if (_currentStep > 1)
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                  icon:Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.2)),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),

            if (_currentStep == 0)
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white.withOpacity(0.2)),
                  onPressed: () {
                    _pageController.nextPage(
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