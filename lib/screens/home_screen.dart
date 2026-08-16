import 'package:flutter/material.dart';
import 'gradient_background.dart';
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
                  child: Text("Hello there,", style: TextStyle(color: Colors.white, fontSize: 40))
              ),
              AnimatedOpacity(
                opacity: _opacity2,
                duration: const Duration(milliseconds: 800),
                child: Text("I'm Moodora", style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
              AnimatedOpacity(
                opacity: _opacity3,
                duration: const Duration(milliseconds: 900),
                child: Text('A quiet space for your thoughts', style: TextStyle(color: Colors.white54, fontSize: 15),),
              ),
              const SizedBox(height: 280,),
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
                  child: const Text("continue",),
                ),
              )
            ],
          ),
      ),
    );
  }
}
