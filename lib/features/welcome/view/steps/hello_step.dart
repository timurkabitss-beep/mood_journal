import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_journal/features/welcome/state/onboarding_state.dart';
import '../../../../ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/font.dart';



class HelloStep extends StatefulWidget{
  final VoidCallback onNext;
  final VoidCallback onHaveAccount;
  const HelloStep(
      { super.key,
        required this.onNext,
        required this.onHaveAccount,
      }
      );
  @override
  State<HelloStep> createState() => _CreateHelloStep();
}

class _CreateHelloStep extends State<HelloStep>{
  double _opacity = 0.0;

  @override
  void initState(){
    Future.delayed(Duration(milliseconds:500), (){
      setState(() {
        _opacity = 1.0;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 240,),
              AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 400),
                  child: Text("Hello there,", style: style)
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 400),
                child: Text("I'm Moodora", style: style),
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 400),
                child: Text('A quiet space for your thoughts', style: style1),
              ),
              const SizedBox(height: 240,),
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 400),
                child:
                ElevatedButton(
                  onPressed: (){
                    widget.onNext();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(220, 54),
                  ),
                  child: Text("HELLO, MOODORA", style: style2),
                ),
              ),
              const SizedBox(height: 15,),
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 400),
                child:
                ElevatedButton(
                  onPressed: (){
                    widget.onHaveAccount();
                  },
                  child: Text("I HAVE A ACCOUNT", style: style2_1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(220, 54),
                  ),
                ),
              ),
         ],
    );
  }
}
