import 'package:flutter/material.dart';


class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context){
    return Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                [
                  Color.fromARGB(255, 86, 0, 168),
                  Color.fromARGB(255, 47, 136, 177),
                ]
            )
        ),
        child: SafeArea(child: child)
    );
  }

}