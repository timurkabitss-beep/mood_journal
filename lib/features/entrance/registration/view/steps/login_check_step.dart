import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/fonts/font.dart';
import 'package:provider/provider.dart';

class LoginCheckStep extends StatefulWidget {
  final VoidCallback onNext;
  const LoginCheckStep({super.key, required this.onNext});

  @override
  State<LoginCheckStep> createState() => _LoginCheckStepState();
}

class _LoginCheckStepState extends State<LoginCheckStep> {
  bool _isEmailValid = false;
  bool _isEmailMatch = false;
  double _opacity = 0.0;
  final TextEditingController _emailController1 = TextEditingController();
  final TextEditingController _emailController2 = TextEditingController();

  @override
  void dispose(){
    _emailController1.dispose();
    _emailController2.dispose();
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
    _emailController1.addListener(_validateEmails);
    _emailController2.addListener(_validateEmails);
  }

  void _validateEmails(){
    final email1 = _emailController1.text.trim();
    final email2 = _emailController2.text.trim();

    final emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );

    final bool isValidFormat = emailRegExp.hasMatch(email1);
    final bool isMatch = email1 == email2&&email2.isNotEmpty;

    if (isValidFormat != _isEmailValid || isMatch != _isEmailMatch){
      setState(() {
         _isEmailValid = isValidFormat;
         _isEmailMatch = isMatch;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<AppState>();
    final currentTheme = onboardProvider.selectedTheme;
    final bool isButtonActive = _isEmailValid && _isEmailMatch;

    return Stack(
      children: [
        const SizedBox(height: 200,),
        Positioned.fill(
          top: 0,
          left: 0,
          right: 0,
          bottom: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:  Text(
                  "Perfect, let’s set up your profile!",
                  textAlign: TextAlign.center,
                  style: style3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:  Text(
                  "Enter your email address.",
                  textAlign: TextAlign.center,
                  style: style1,
                ),
              ),
              const SizedBox(height: 160,),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child:
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 400),
                child: TextField(
                  controller: _emailController1,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  decoration: InputDecoration(
                      hintText: "Email...",
                      hintStyle: style4,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 400),
                  child: TextField(
                    controller: _emailController2,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    decoration: InputDecoration(
                        hintText: "Confirm email...",
                        hintStyle: style4,
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.15),
                        contentPadding: const EdgeInsets.symmetric(vertical: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 120,),
        Positioned(
          bottom: 70,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: isButtonActive ? 1.0 : 0.25,
            duration: const Duration(milliseconds: 0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(220, 54),
                  foregroundColor: currentTheme.colors[0].withOpacity(0.2),
                ),
                onPressed: () {
                  if(isButtonActive){
                    final email = _emailController2.text.trim();
                    context.read<AppState>().setEmail(email);
                    widget.onNext();
                  }
                },
                child: Text(
                  "CONTINUE",
                  style: style5.copyWith(color: currentTheme.colors[0]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
