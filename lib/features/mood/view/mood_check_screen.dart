import 'package:flutter/material.dart';
import 'package:mood_journal/features/name/model/user_data.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';

import '../../../ui/fonts/all_fonts.dart';

class MoodCheckScreen extends StatefulWidget {
  const MoodCheckScreen({super.key});

  @override
  State<MoodCheckScreen> createState() => _MoodCheckScreenState();
}

class _MoodCheckScreenState extends State<MoodCheckScreen> {
  AppThemeModel _appThemeModel = globalSelectedTheme;
  double _opacity = 0.0;

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
          child: Stack(
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
              Positioned.fill(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),
                          AnimatedOpacity(
                            opacity: _opacity,
                            duration: const Duration(milliseconds: 500),
                            child: Text("Hey $globalUserName! What’s your vibe right now?",
                                textAlign: TextAlign.center,
                                style: style3
                            ) ,
                          ),
                          const SizedBox(height: 200,),
                          AnimatedOpacity(
                            opacity: _opacity,
                            duration: const Duration(milliseconds: 500),

                          )
                        ],
                      ),
                  )
              )
            ],
          )
      )
    );
  }
}
