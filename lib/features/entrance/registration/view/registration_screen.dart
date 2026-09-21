import 'package:flutter/material.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'steps/login_check_step.dart';
import 'steps/psw_check_step.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  @override
  void dispose() {
    _pageController.dispose(); // Обязательно освобождаем память
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;
    final themeColors = currentTheme.colors;

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
                       _currentStep = index; // Запоминаем, на каком мы шаге
                     });
                   },
                   children: [
                     LoginCheckStep(
                       onNext: () {
                       setState(() {

                       });
                       _pageController.nextPage(
                         duration: const Duration(milliseconds: 700),
                         curve: Curves.easeInOut,
                       );
                     },
                     ),
                     PswCheckStep(
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
             Positioned(
               top: 40,
               right: 20,
               child: IconButton(
                 icon: Icon(Icons.close, color: Colors.white.withOpacity(0.2)),
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
               ),
             ),
           ],
         )
     )
    );
  }
}
