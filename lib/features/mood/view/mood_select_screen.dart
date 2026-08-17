import 'package:flutter/material.dart';

class MoodSelectScreen extends StatefulWidget{
  const MoodSelectScreen({super.key});
  @override
  State<MoodSelectScreen> createState() => _MoodSelectScreenState();
}

class _MoodSelectScreenState extends State<MoodSelectScreen>{
  double _curSliderVal = 2.0;
  final List<String> emojis = ['🥳', '🙂', '😐', '🙁', '😢'];
  final List<String> labels = ['Отлично', 'Хорошо', 'Нормально', 'Плохо', 'Ужасно'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emojis[_curSliderVal.round()]),
          Text(labels[_curSliderVal.round()]),
          Slider
            (
            value: _curSliderVal,
            onChanged: (newVal){
              setState(() => _curSliderVal = newVal);
            },
            min: 0,
            max: 4,
            activeColor: Colors.blueAccent,
          )
        ],
      ),

    );
  }
}