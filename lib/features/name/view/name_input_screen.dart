import 'package:flutter/material.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/font.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GradientBackground(
        child: Column(
          children: [
            Text("Input your name", style: style),
          ],
        ),
      ),
    );
  }
}
