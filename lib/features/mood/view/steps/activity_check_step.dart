import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/feelings_screen_arguments.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/features/welcome/state/onboarding_state.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:provider/provider.dart';
import '../../models/activity_model.dart';
import '../../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ActivityCheckStep extends StatefulWidget {
  final MoodModel chosenMood;
  final Function(List<ActivityModel>) onNext;
  const ActivityCheckStep({super.key, required this.chosenMood, required this.onNext});

  @override
  State<ActivityCheckStep> createState() => _ActivityCheckStepState();
}

class _ActivityCheckStepState extends State<ActivityCheckStep> {
  double _opacity = 0.0;
  final List<ActivityModel> _selectedActivities = [];
  bool _isActivityChanged = false;



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
    return
          Stack(
            children: [
              const SizedBox(height: 200,),
              Positioned.fill(
                top: 0,
                left: 0,
                right: 0,
                bottom: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child:  Text(
                            "What’s making your day so ${widget.chosenMood.label.toLowerCase()}?",
                            textAlign: TextAlign.center,
                            style: style3,
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child:  Text(
                            "Select up to 10 activities",
                            textAlign: TextAlign.center,
                            style: style1,
                        ),
                      ),

                      Expanded(
                          child:
                           Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                    top: 60,
                                    bottom: 20,
                                  ),
                                  child: GridView.builder(
                                      padding: const EdgeInsets.only(left: 25, right: 15),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ActivityModel.values.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (BuildContext context, int index){
                                        final activity = ActivityModel.values[index];
                                        final isSelected = _selectedActivities.contains(activity);

                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              if (_selectedActivities.contains(activity)){
                                                _selectedActivities.remove(activity);
                                              }
                                              else{
                                                _selectedActivities.add(activity);
                                              }
                                              _isActivityChanged = _selectedActivities.isNotEmpty && _selectedActivities.length <= 10;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 10),
                                            decoration: BoxDecoration(
                                                color: isSelected ? Colors.white : Colors.transparent,
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  activity.assetPath,
                                                  colorFilter:
                                                  ColorFilter.mode(
                                                    isSelected ? currentTheme.colors[0] : Colors.white,
                                                    BlendMode.srcIn,
                                                  ),
                                                  width: 32,
                                                  height: 32,
                                                ),
                                                Text(
                                                  activity.label,
                                                  textAlign: TextAlign.center,
                                                  style: style5.copyWith(
                                                    color: isSelected ? currentTheme.colors[0] : Colors.white.withOpacity(0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                      ),
                    ],
                  ),
              ),
              const SizedBox(height: 120,),
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _opacity * (_isActivityChanged ? 1.0 : 0.25),
                  duration: const Duration(milliseconds: 10),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(220, 54),
                        foregroundColor: currentTheme.colors[0].withOpacity(0.2),
                      ),
                      onPressed: () {
                        if (_isActivityChanged) {
                           widget.onNext(_selectedActivities);

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
