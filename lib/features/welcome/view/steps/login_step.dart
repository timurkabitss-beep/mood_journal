import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/fonts/font.dart';
import 'package:provider/provider.dart';

import '../../../../core/data/auth_repository.dart';

class LoginStep extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  final VoidCallback onBack;
  const LoginStep({super.key, required this.onLoginSuccess, required this.onBack});

  @override
  State<LoginStep> createState() => _LoginStepState();
}

class _LoginStepState extends State<LoginStep> {
  bool _isLoading = false;
  double _opacity = 0.0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
  _emailController.dispose();
  _passwordController.dispose();
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
  _emailController.addListener(() {
    setState(() {}); // Перезапускаем build, чтобы пересчитать isButtonActive
  });

  _passwordController.addListener(() {
    setState(() {});
  });
  }


  @override
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<AppState>();
    final currentTheme = onboardProvider.selectedTheme;

    final bool isButtonActive = _emailController.text.trim().isNotEmpty &&
                                _passwordController.text.trim().isNotEmpty;

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
                  "Welcome back",
                  textAlign: TextAlign.center,
                  style: style3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:  Text(
                  "Please enter your credentials to continue.",
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
                  child:
                  TextField(
                  controller: _emailController,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  decoration: InputDecoration(
                      hintText: "Your email...",
                      hintStyle: style4,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none
                      )
                    )
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 400),
                  child:
                  TextField(
                  controller: _passwordController,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  decoration: InputDecoration(
                      hintText: "Your password...",
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
                onPressed: () async {
                  if (isButtonActive && !_isLoading) {
                    setState(() {
                      _isLoading = true;
                    });

                    final email = _emailController.text.trim();
                    final password = _passwordController.text;
                    final authRepo = AuthRepository();

                    final isValid = await authRepo.verifyCredentials(email, password);

                    if (!mounted) return;

                    if (isValid) {
                      context.read<AppState>().setEmail(email);
                      widget.onLoginSuccess();
                    } else {
                      setState(() {
                        _isLoading = false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Invalid email or password. Please try again.'),
                          backgroundColor: Colors.red.shade400,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "LET'S GO",
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
