import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/name/data/user_data.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import '../../mood/models/mood_model.dart';
import '../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MoodCheckScreen extends StatefulWidget {
  const MoodCheckScreen({super.key});

  @override
  State<MoodCheckScreen> createState() => _MoodCheckScreenState();
}

class _MoodCheckScreenState extends State<MoodCheckScreen> {
  AppThemeModel _appThemeModel = globalSelectedTheme;
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
    return Scaffold(
      body: GradientBackground(
          colors: globalSelectedTheme.colors,
          child: 
          Stack(
            children: [
              Positioned(
                  top: 20,
                  right: 20 ,
                  child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 500),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white.withOpacity(0.2),),
                        onPressed: (){
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                      ) ,
                  ),
              ),
              Positioned.fill(
                  child:
                   Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                       const SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child:
                              AnimatedOpacity(
                                opacity: _opacity,
                                duration: const Duration(milliseconds: 500),
                                child: Text("Hey $globalUserName! What’s your vibe right now?",
                                  textAlign: TextAlign.center,
                                   style: style3
                               ) ,
                            ),),
                          const SizedBox(height: 140,),
                          AnimatedOpacity(
                            opacity: _opacity,
                            duration: const Duration(milliseconds: 900),
                            child: SvgPicture.asset(
                                _currentMood.assetsPath,
                                width: 120,
                                height: 120,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          AnimatedOpacity(
                            opacity: _opacity,
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                                _currentMood.label,
                                style: style1
                            ),
                          ),
                          const SizedBox(height: 40,),
                          AnimatedOpacity(
                            opacity: _opacity,
                            duration: const Duration(milliseconds: 500),
                            child:
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
                          ),
                        ],
                      ),
                  ),
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _opacity * (_isMoodChanged ? 1.0 : 0.25),
                  duration: const Duration(milliseconds: 500),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(220, 54),
                        foregroundColor: globalSelectedTheme.colors[0].withOpacity(0.2),
                      ),
                      onPressed: () {
                        if (_isMoodChanged) {
                          setState(() {
                            Navigator.of(context).pushNamed('/activity_check_screen', arguments: _currentMood);
                          });
                        }
                      },
                      child: Text(
                        "CONTINUE",
                        style: style5.copyWith(color: globalSelectedTheme.colors[0]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      )
    );
  }
}
