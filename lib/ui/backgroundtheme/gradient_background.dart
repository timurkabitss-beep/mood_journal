import 'package:flutter/material.dart';


class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  const GradientBackground({super.key, required this.child, this.colors });

  @override
  Widget build(BuildContext context){
    final List<Color> currentColors = colors ?? [
      const Color(0xFF4A5568),
      const Color(0xFF6366F1),
      const Color(0xFF5B21B6),
    ];

    return AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: currentColors,
            )
        ),
        child: SafeArea(child: child)
    );
  }


}