import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MoodEntryWidget extends StatefulWidget {
  const MoodEntryWidget({super.key});

  @override
  State<MoodEntryWidget> createState() => _MoodEntryWidgetState();
}

class _MoodEntryWidgetState extends State<MoodEntryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0,4)
          )
        ],
      ),
    );
  }
}
