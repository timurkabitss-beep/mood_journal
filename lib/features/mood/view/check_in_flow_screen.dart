import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/features/mood/view/steps/feelings_check_step.dart';
import 'package:mood_journal/features/mood/view/view.dart';
import 'package:mood_journal/features/name/data/user_data.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import '../../mood/models/activity_model.dart';
import '../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

import 'steps/activity_check_step.dart';
import 'steps/mood_check_step.dart';

class CheckInFlowScreen extends StatefulWidget {
  const CheckInFlowScreen({super.key,});

  @override
  State<CheckInFlowScreen> createState() => _CheckInFlowScreenState();
}

class _CheckInFlowScreenState extends State<CheckInFlowScreen> {
  final PageController _pageController = PageController();

  MoodModel? _chosenMood;
  List<ActivityModel> _selectedActivities = [];
  List<FeelingModel> _selectedFeelings = [];

  int _currentStep = 0;

  @override
  void dispose() {
    _pageController.dispose(); // Обязательно освобождаем память
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        colors: globalSelectedTheme.colors,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: _pageController,
                // Отключаем свайп пальцем, перелистывать можно ТОЛЬКО по кнопкам!
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index; // Запоминаем, на каком мы шаге
                  });
                },
                children: [
                  MoodCheckStep(
                    onNext: (mood) {
                       setState(() {
                          _chosenMood = mood;
                       });
                       _pageController.nextPage(
                       duration: const Duration(milliseconds: 700),
                       curve: Curves.easeInOut,
                          );
                       },
                  ),
                  ActivityCheckStep(
                    chosenMood: _chosenMood ?? MoodModel.neutral,
                    onNext: (activities) {
                      setState(() {
                        _selectedActivities = activities;
                      });
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  FeelingsCheckStep(
                      onNext: (feelings){
                        setState(() {
                          _selectedFeelings = feelings;
                        });
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeInOut,
                        );
                      }
                  ),
                  MoodSummaryStep(

                      chosenActivities: _selectedActivities,
                      chosenFeelings: _selectedFeelings
                  )
                ],
              ),
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
        ),
      ),
    );
  }
}
