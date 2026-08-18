import 'package:flutter/material.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/font.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  bool isName = false;
  String? name;
  double _opacity = 0.0;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }


  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      setState(() {
        _opacity = 1.0;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GradientBackground(
          child: Stack(
            children: [
              Positioned(
                  top: 20,
                  left: 20,
                  child:
                  AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 400),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white,),
                        onPressed: (){
                           Navigator.of(context).pop();
                        },
                     ),
                 ),
              ),
              Positioned.fill(
                child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 400),
                          child: Text("So nice to meet you!\n What is your name?",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 26,
                                     // fontWeight: FontWeight.w500
                                 )
                              ) ,
                      ),
                      const SizedBox(height: 200,),
                      AnimatedOpacity(
                          opacity: _opacity,
                          duration: const Duration(milliseconds: 400),
                          child: TextField(
                            controller: _controller,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                            decoration: InputDecoration(
                                hintText: "Your nickname...",
                                hintStyle: const TextStyle(color: Colors.white54, fontSize: 22),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.15),
                                contentPadding: const EdgeInsets.symmetric(vertical: 22),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none
                                )
                            ),
                          ),
                      ),
                      const SizedBox(height: 250,),
                      AnimatedOpacity(
                        opacity: _opacity,
                        duration: const Duration(milliseconds: 400),
                        child:
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              Navigator.of(context).pushNamed('/mood');
                            });
                          },
                          child: const Text("continue",),
                        ),
                      )
                     ],
                    ),
                  ),
                ),
            ],
          )
      ),
    );
  }
}
