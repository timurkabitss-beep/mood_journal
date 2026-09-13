import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mood_journal/features/mood/models/activity_model.dart';
import 'package:mood_journal/features/mood/models/models.dart';
import 'package:mood_journal/features/mood/models/mood_model.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import '../../../welcome/data/user_data.dart';
import '../../models/activity_model.dart';
import '../../../../ui/fonts/all_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';


class MoodSummaryStep extends StatefulWidget {

  final List<ActivityModel> chosenActivities;
  final List<FeelingModel> chosenFeelings;
  const MoodSummaryStep({
    super.key,
    required this.chosenActivities,
    required this.chosenFeelings
  });

  @override
  State<MoodSummaryStep> createState() => _MoodSummaryStepState();
}

class _MoodSummaryStepState extends State<MoodSummaryStep> {
  double _opacity = 0.0;
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notescontroller = TextEditingController();
  final DateTime _currentDate = DateTime.now();


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
    final themeColors = globalSelectedTheme.colors;
    return
          Stack(
           children: [
             Positioned.fill(
               child:  SingleChildScrollView(
                     padding: const EdgeInsets.only(
                       top: 100,
                       bottom: 150,
                       left: 0,
                       right: 0,
                     ),
                     child: Column(
                       children: [
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child:
                           Text(
                           DateFormat(
                               'MMMM: d,  hh:mm a').format(_currentDate),
                           style: style1.copyWith(color: Colors.white),
                           ),
                          ),
                         const SizedBox(height: 50),

                         if (widget.chosenActivities.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3265),
                            child: Align(
                             alignment: Alignment.centerLeft,
                             child: Text(
                               "Activities",
                               style: TextStyle(color: Colors.white54, fontSize: 30, fontWeight: FontWeight.w500),
                             ),
                           ),
                          ),
                           Align(
                             alignment: Alignment.centerLeft,
                             child:
                             SingleChildScrollView(
                                 scrollDirection: Axis.horizontal,
                                 physics: const BouncingScrollPhysics(),
                                 padding: const EdgeInsets.symmetric(horizontal: 32),
                                 child: Row(
                                   spacing: 10,
                                   children: widget.chosenActivities.map((activity) {
                                     return Container(
                                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.circular(20),
                                       ),
                                       child: Row(
                                         mainAxisSize: MainAxisSize.min,
                                         children: [
                                           SvgPicture.asset(
                                             activity.assetPath,
                                             width: 20,
                                             height: 20,
                                             color: themeColors[0],
                                           ),
                                           const SizedBox(width: 8),
                                           Text(
                                             activity.label,
                                             style: style5.copyWith(color: themeColors[0], fontWeight: FontWeight.bold),
                                           ),
                                         ],
                                       ),
                                     );
                                   }).toList(),
                                 ),
                             ),
                           ),
                           const SizedBox(height: 24),
                         ],
                         if (widget.chosenFeelings.isNotEmpty) ...[
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Align(
                             alignment: Alignment.centerLeft,
                             child: Text(
                               "Feelings",
                               style: TextStyle(color: Colors.white54, fontSize: 30, fontWeight: FontWeight.w500),
                             ),
                           ),
                          ),
                          Align(
                           alignment: Alignment.centerLeft,
                           child:
                           SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  spacing: 10,
                                  children: widget.chosenFeelings.map((feeling) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            feeling.assetPath,
                                            width: 20,
                                            height: 20,
                                            color: themeColors[0],
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            feeling.label,
                                            style: style5.copyWith(color: themeColors[0], fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ),
                         const SizedBox(height: 80),
                         ],
                         Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child:
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
                             )
                           ),
                         ),
                         const SizedBox(height: 30),
                         Padding(
                         padding:const EdgeInsets.symmetric(horizontal: 32),
                         child:
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
                         )
                       ],
                     )
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
    );
  }
}
