import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';
import '../../../../ui/fonts/all_fonts.dart';

import '../../models/feeling_model.dart';

class FeelingsCheckStep extends StatefulWidget {
  final Function(List<FeelingModel>) onNext;
  const FeelingsCheckStep({super.key, required this.onNext});

  @override
  State<FeelingsCheckStep> createState() => _FeelingsCheckStepState();
}

class _FeelingsCheckStepState extends State<FeelingsCheckStep> {

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
    final onboardProvider = context.watch<AppState>();
    final currentTheme = onboardProvider.selectedTheme;

    return Stack(
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
                            "And how are you feeling inside?",
                            textAlign: TextAlign.center,
                            style: style3,
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                            "Select your emotions",
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
                                    itemCount: FeelingModel.values.length,
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
                                                  isSelected ? currentTheme.colors[0] : Colors.white,
                                                  BlendMode.srcIn,
                                                ),
                                                width: 32,
                                                height: 32,
                                              ),
                                              Text(
                                                feeling.label,
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
                    opacity: _isFeelingsChanged ? 1.0 : 0.25,
                    duration: const Duration(milliseconds: 0),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(220, 54),
                          foregroundColor: currentTheme.colors[0].withOpacity(0.2),
                        ),
                        onPressed: () {
                          if (_isFeelingsChanged) {
                            widget.onNext(_selectedFeelings);
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
