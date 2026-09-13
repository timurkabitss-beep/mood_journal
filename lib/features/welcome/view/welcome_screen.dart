import "package:flutter/material.dart";
import "package:mood_journal/features/welcome/data/user_data.dart";
import "package:mood_journal/features/welcome/view/steps/background_choice_screen.dart";
import "package:mood_journal/features/welcome/view/steps/hello_step.dart";
import "package:mood_journal/features/welcome/view/steps/name_input_screen.dart";
import "package:mood_journal/ui/backgroundtheme/gradient_background.dart";
import "package:mood_journal/ui/theme/theme.dart";

import "../../../ui/theme/app_theme_model.dart";

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  AppThemeModel _currentBackgroundTheme = backThemes[0];


  String _userName = ' ';

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  void _moveToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
          colors: _currentBackgroundTheme.colors,
          child: Stack(
            children: [
              Positioned.fill(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index){
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    children: [
                      HelloStep(
                          onNext: _moveToNextPage,
                          onHaveAccount: (){
                            Navigator.of(context).pushNamed('/login');
                          }
                      ),
                      NameInputStep(
                        onNext: (name) {
                          _userName = name;
                          _moveToNextPage(); // Листаем дальше
                        },
                      ),
                      BackgroundChoiceStep(
                          userName: _userName,
                          onThemeChanged: (newTheme){
                            setState(() {
                              _currentBackgroundTheme = newTheme;
                            });
                          },
                          onSave: () async {
                            globalUserName = _userName;
                            globalSelectedTheme = _currentBackgroundTheme;

                            if(mounted){
                              Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);
                            }
                          }
                      )
                    ],
                  )
              ),
              if (_currentStep > 0)
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.2)),
                    onPressed: () {
                      // Хлёстко и синхронно катимся назад
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
            ],
          ),
      )
    );
  }
}
