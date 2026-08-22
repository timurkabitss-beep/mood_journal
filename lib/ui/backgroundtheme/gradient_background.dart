import 'package:flutter/material.dart';


class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  const GradientBackground({super.key, required this.child, this.colors });

  @override
  Widget build(BuildContext context){
    final List<Color> currentColors = colors ?? [
      const Color.fromARGB(255, 86, 0, 168),
      const Color.fromARGB(255, 47, 136, 177),
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