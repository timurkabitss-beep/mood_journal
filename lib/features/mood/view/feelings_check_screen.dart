import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/features/name/data/user_data.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import '../../mood/models/activity_model.dart';
import '../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../models/feeling_model.dart';

class FeelingsCheckScreen extends StatefulWidget {
  const FeelingsCheckScreen({super.key});

  @override
  State<FeelingsCheckScreen> createState() => _FeelingsCheckScreenState();
}

class _FeelingsCheckScreenState extends State<FeelingsCheckScreen> {
  AppThemeModel _appThemeModel = globalSelectedTheme;
  double _opacity = 0.0;
  final List<FeelingModel> _selectedFeelings = [];
  bool _isFeelingsChanged = false;

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
                          Navigator.of(context).pushNamed('/dashboard');
                        });
                      },
                    ) ,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20 ,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 500),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.2),),
                      onPressed: (){
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                    ) ,
                  ),
                ),
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
                        child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            "And how are you feeling inside?",
                            textAlign: TextAlign.center,
                            style: style3,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            "Select your emotions",
                            textAlign: TextAlign.center,
                            style: style1,
                          ),
                        ),
                      ),

                      Expanded(
                        child:
                        AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            color: Colors.transparent,
                            child: AnimatedOpacity(
                              opacity: _opacity,
                              duration: const Duration(milliseconds: 500),
                              child:  Padding(
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
                                      final feeling = FeelingModel.values[index];
                                      final isSelected = _selectedFeelings.contains(feeling);

                                      return GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            if (_selectedFeelings.contains(feeling)){
                                              _selectedFeelings.remove(feeling);
                                            }
                                            else{
                                              _selectedFeelings.add(feeling);
                                            }
                                            _isFeelingsChanged = _selectedFeelings.isNotEmpty;
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
                                                feeling.assetPath,
                                                colorFilter:
                                                ColorFilter.mode(
                                                  isSelected ? globalSelectedTheme.colors[0] : Colors.white,
                                                  BlendMode.srcIn,
                                                ),
                                                width: 32,
                                                height: 32,
                                              ),
                                              Text(
                                                feeling.label,
                                                textAlign: TextAlign.center,
                                                style: style5.copyWith(
                                                  color: isSelected ? globalSelectedTheme.colors[0] : Colors.white.withOpacity(0.7),
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
                    opacity: _opacity * (_isFeelingsChanged ? 1.0 : 0.25),
                    duration: const Duration(milliseconds: 10),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(220, 54),
                          foregroundColor: globalSelectedTheme.colors[0].withOpacity(0.2),
                        ),
                        onPressed: () {
                          if (_isFeelingsChanged) {
                            setState(() {
                              Navigator.of(context).pushNamed('/');
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
