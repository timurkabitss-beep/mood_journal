import 'package:flutter/material.dart';
import '../../../ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/font.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _CreateHomeScreen();
}

class _CreateHomeScreen extends State<HomeScreen>{
  double _opacity1 = 0.0;
  double _opacity2 = 0.0;
  double _opacity3 = 0.0;
  double _opacity4 = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), (){
      setState(() {
        _opacity1 = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 900), (){
      setState(() {
        _opacity2 = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 1400), (){
      setState(() {
        _opacity3 = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 2100), (){
      setState(() {
        _opacity4 = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 240,),
              AnimatedOpacity(
                  opacity: _opacity1,
                  duration: const Duration(milliseconds: 600),
                  child: Text("Hello there,", style: style)
              ),
              AnimatedOpacity(
                opacity: _opacity2,
                duration: const Duration(milliseconds: 800),
                child: Text("I'm Moodora", style: style),
              ),
              AnimatedOpacity(
                opacity: _opacity3,
                duration: const Duration(milliseconds: 900),
                child: Text('A quiet space for your thoughts', style: style1),
              ),
              const SizedBox(height: 240,),
              AnimatedOpacity(
                opacity: _opacity4,
                duration: const Duration(milliseconds: 900),
                child:
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).pushNamed('/name_input');
                    });
                  },
                  child: Text("HELLO, MOODORA", style: style2),
                ),
              ),
              const SizedBox(height: 15,),
              AnimatedOpacity(
                opacity: _opacity4,
                duration: const Duration(milliseconds: 900),
                child:
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      Navigator.of(context).pushNamed('/n');
                    });
                  },
                  child: Text("I HAVE A ACCOUNT", style: style2_1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.14)
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
