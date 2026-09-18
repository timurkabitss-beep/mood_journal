import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:mood_journal/features/welcome/state/onboarding_state.dart';
import '../../models/mood_model.dart';
import '../../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MoodCheckStep extends StatefulWidget {
  final Function(MoodModel) onNext;
  const MoodCheckStep({super.key, required this.onNext});

  @override
  State<MoodCheckStep> createState() => _MoodCheckStepState();
}

class _MoodCheckStepState extends State<MoodCheckStep> {

  double _opacity = 0.0;
  MoodModel _currentMood = MoodModel.neutral;
  double _sliderValue = 2.0;
  bool _isMoodChanged = false;




  @override
  void initState(){
    Future.delayed(Duration(milliseconds:500), (){
      setState(() {
        _opacity = 1.0;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<OnboardingState>();
    final currentTheme = onboardProvider.selectedTheme;
    final userName = onboardProvider.userName;

    return
          Stack(
            children: [
              Positioned.fill(
                  child:
                   Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                       const SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child:
                               Text("Hey $userName! What’s your vibe right now?",
                                  textAlign: TextAlign.center,
                                   style: style3
                               ) ,
                            ),
                          const SizedBox(height: 140,),
                           SvgPicture.asset(
                                _currentMood.assetsPath,
                                width: 120,
                                height: 120,
                          ),
                          const SizedBox(height: 20,),
                           Text(
                                _currentMood.label,
                                style: style1
                           ),
                          const SizedBox(height: 40,),
                          SfSlider(
                                value: _sliderValue,
                                min: 0,
                                max: 4,
                                activeColor: Colors.white,
                                inactiveColor: Colors.white.withOpacity(0.1),
                                onChanged: (newValue){
                                  setState(() {
                                    _isMoodChanged = true;
                                    _sliderValue = newValue;
                                    _currentMood = MoodModel.values[newValue.round()];
                                  });
                                },
                              ),
                        ],
                      ),
                  ),
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _isMoodChanged ? 1.0 : 0.25,
                  duration: const Duration(milliseconds: 0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(220, 54),
                        foregroundColor: currentTheme.colors[0].withOpacity(0.2),
                      ),
                      onPressed: () {
                        if (_isMoodChanged) {
                          widget.onNext(_currentMood);
                        }
                      },
                      child: Text(
                        "CONTINUE",
                        style: style5.copyWith(color: currentTheme.colors[0]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
    );
  }
}
