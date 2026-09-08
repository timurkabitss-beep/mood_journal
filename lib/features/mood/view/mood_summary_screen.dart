import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/features/name/data/user_data.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import '../../mood/models/activity_model.dart';
import '../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';


class MoodSummaryScreen extends StatefulWidget {
  final MoodEntryModel entryModel;
  const MoodSummaryScreen({super.key, required this.entryModel});

  @override
  State<MoodSummaryScreen> createState() => _MoodSummaryScreenState();
}

class _MoodSummaryScreenState extends State<MoodSummaryScreen> {
  double _opacity = 0.0;


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });
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
            child: IconButton(
                icon: Icon(Icons.close, color: Colors.white.withOpacity(0.2),),
                onPressed: (){
                  setState(() {
                    Navigator.of(context).pushNamed('/dashboard');
                  });
                },
            ),
          ),
          Positioned(
            top: 20,
            left: 20 ,
            child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.2),),
                onPressed: (){
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
            ),
          ),
          const SizedBox(height: 200,),
          Expanded(
              child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 500),

              )
          ),
          // Positioned.fill(
          //       top: 0,
          //       left: 0,
          //       right: 0,
          //       bottom: 200,
          //       child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             const SizedBox(height: 100),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 32),
          //               child: AnimatedOpacity(
          //                 opacity: _opacity,
          //                 duration: const Duration(milliseconds: 500),
          //                 child: Text(
          //                   DateFormat('MMMM d, h:mm, a').format(widget.entryModel.date).toUpperCase()  ,
          //                   textAlign: TextAlign.center,
          //                   style: style3,
          //                 ),
          //               ),
          //             ),
          //           ]
          //       )
          //    ),
              const SizedBox(height: 120,),
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 10),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(220, 54),
                        foregroundColor: globalSelectedTheme.colors[0].withOpacity(0.2),
                      ),
                      onPressed: () {
                        },
                      child: Text(
                        "CONTINUE",
                        style: style5.copyWith(color: globalSelectedTheme.colors[0]),
                      ),
                    ),
                  ),
                ),
              ),
          ]
        )
     )
    );
  }
}
