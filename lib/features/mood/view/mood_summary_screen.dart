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
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notescontroller = TextEditingController();

  @override
  void dispose(){
    _titlecontroller.dispose();
    _notescontroller.dispose();
    super.dispose();
  }


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
             Positioned.fill(
               child: AnimatedOpacity(
                 opacity: _opacity,
                 duration: const Duration(milliseconds: 500),
                 child: SingleChildScrollView(
                     padding: const EdgeInsets.only(
                       top: 100,
                       bottom: 10,
                       left: 16,
                       right: 16,
                     ),
                     child: Column(
                       children: [
                         Text(
                           DateFormat(
                               'MMMM: d,  hh:mm a').format(widget.entryModel.date),
                           style: style1.copyWith(color: Colors.white),
                         ),
                         const SizedBox(height: 340),
                         TextField(
                           controller: _titlecontroller,
                           textAlign: TextAlign.left,
                           style: style1.copyWith(color: Colors.white),
                           decoration: InputDecoration(
                               hintText: "Title...",
                               hintStyle: style1,
                               filled: true,
                               fillColor: Colors.white.withOpacity(0.15),
                               contentPadding: const EdgeInsets.symmetric(vertical: 22),
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(16),
                                   borderSide: BorderSide.none
                               )
                           ),
                         ),
                         const SizedBox(height: 30,),
                         TextField(
                           controller: _notescontroller,
                           textAlign: TextAlign.left,
                           minLines: 3,
                           maxLines: null,
                           style: style1.copyWith(color: Colors.white),
                           decoration: InputDecoration(
                               hintText: "Add some notes...",
                               hintStyle: style1,
                               filled: true,
                               fillColor: Colors.white.withOpacity(0.15),
                               contentPadding: const EdgeInsets.symmetric(vertical: 20),
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(16),
                                   borderSide: BorderSide.none
                               )
                           ),
                         ),
                       ],
                     )
                 ),
               ),
             ),
            Positioned(
            top: 20,
            right: 20 ,
            child: IconButton(
                icon: Icon(Icons.close, color: Colors.white.withOpacity(0.2),),
                onPressed: (){
                  Navigator.of(context).pushNamed('/dashboard');
                },
              ),
            ),
            Positioned(
             top: 20,
             left: 20 ,
             child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white.withOpacity(0.2),),
                onPressed: (){
                    Navigator.of(context).pop();
                },
              ),
             ),


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
                        "COMPLETE CHECK-IN",
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
