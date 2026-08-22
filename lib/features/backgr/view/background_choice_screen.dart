import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import '../../name/model/user_data.dart';

class BackgroundChoiceScreen extends StatefulWidget {
  const BackgroundChoiceScreen({super.key});

  @override
  State<BackgroundChoiceScreen> createState() => _BackgroundChoiceScreenState();
}

class _BackgroundChoiceScreenState extends State<BackgroundChoiceScreen> {
  AppThemeModel _appThemeModel = backThemes[0];
  double _opacity = 0.0;

  @override
  void initState(){
    Future.delayed(Duration(milliseconds:300), (){
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
        colors: _appThemeModel.colors,
        child: Stack(
          children: [
            Positioned(
                top: 20,
                left: 20,
                child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: const Duration(milliseconds: 400),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,  color:  Colors.white.withOpacity(0.2),),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                ),
            ),
            Positioned.fill(
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 400),
                      child: Text("Topics, ${globalUserName}!\n Which topic do you like?",
                          textAlign: TextAlign.center,
                          style: style3
                      ) ,
                    ),
                    const SizedBox(height: 200,),
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 400),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Row(
                          children: [
                            for (var theme in backThemes)
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _appThemeModel = theme;
                                  });
                                },
                                child: AnimatedContainer(
                                    height: 90,
                                    width: 90,
                                    duration: Duration(milliseconds: 400),
                                    margin: const EdgeInsets.symmetric(horizontal: 14),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: theme.colors,
                                      ),
                                      border: Border.all(
                                          color: theme.id == _appThemeModel.id ? Colors.white : Colors.transparent,
                                          width: 4,
                                      ),
                                      boxShadow:  [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),)
                                      ],
                                    ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ),
                    const SizedBox(height: 200,),
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 400),
                      child:
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: _appThemeModel.colors[0],
                        ),
                        onPressed:  (){
                          Navigator.of(context).pushNamed('/background');
                        },
                        child: Text("NEXT", style: style5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
