import 'package:flutter/material.dart';
import 'package:mood_journal/ui/backgroundtheme/gradient_background.dart';
import 'package:mood_journal/ui/fonts/font.dart';
import '../../../welcome/data/user_data.dart';
import 'package:mood_journal/ui/fonts/font.dart';


class NameInputStep extends StatefulWidget {
  final Function(String) onNext;
  const NameInputStep({super.key, required this.onNext});

  @override
  State<NameInputStep> createState() => _NameInputStepState();
}

class _NameInputStepState extends State<NameInputStep> {
  bool isName = false;
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
    _controller.addListener(_validateName);
  }

  void _validateName(){
    final text = _controller.text.trim();
    final regExp = RegExp(r'^[a-zA-Z\u0410-\u044f\u0401\u0451]+$');

    final bool isValid = text.isNotEmpty && regExp.hasMatch(text);

    if (isValid != isName){
      setState(() {
        isName = isValid;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
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
                                 style: style3
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
                                hintStyle: style4,
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
                          onPressed: isName ? (){
                              globalUserName = _controller.text.trim();
                              widget.onNext(globalUserName);
                          } : null ,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(220, 54),
                          ),
                          child: Text("CONTINUE", style: style5),
                        ),
                      ),
                     ],
                    ),
                 ),
                ),
              )
          ],
       );
    }
}
