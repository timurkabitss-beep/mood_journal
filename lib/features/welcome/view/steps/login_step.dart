import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/fonts/font.dart';
import 'package:provider/provider.dart';

import '../../../../core/data/repositories/auth_repository.dart';

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
  final AuthRepository _authRepo = AuthRepository();

  @override
  void dispose(){
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    _emailController.addListener(() {
      if (mounted) setState(() {});
    });
    _passwordController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      // Пытаемся войти. Если успешно, код пойдет дальше, если нет — прыгнет в catch
      await _authRepo.login(email, password);

      if (!mounted) return;

      // Успешный вход!
      print("🎉 Успешный вход!");
      context.read<AppState>().setEmail(email); // Сохраняем для UI, если нужно
      widget.onLoginSuccess(); // Передаем управление наверх

    } on FirebaseAuthException catch (e) {
      // Обрабатываем конкретные ошибки Firebase
      if (!mounted) return;

      String errorMessage = 'Invalid email or password.';

      if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
        errorMessage = 'Invalid email or password. Please try again.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many failed attempts. Please try again later.';
      } else {
        errorMessage = e.message ?? 'An error occurred during login.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    } catch (e) {
      // Любые другие непредвиденные ошибки
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An unexpected error occurred.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      // Гарантированно выключаем загрузку, независимо от успеха или ошибки
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<AppState>();
    final currentTheme = onboardProvider.selectedTheme;

    final bool isButtonActive = _emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty &&
        !_isLoading;

    return Stack(
      children: [
        const SizedBox(height: 200),
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
                child: Text(
                  "Welcome back",
                  textAlign: TextAlign.center,
                  style: style3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Please enter your credentials to continue.",
                  textAlign: TextAlign.center,
                  style: style1,
                ),
              ),
              const SizedBox(height: 160),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 400),
                  child: TextField(
                    controller: _emailController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.emailAddress, // Добавил для удобства (откроет клавиатуру с @)
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                    decoration: InputDecoration(
                      hintText: "Your email...",
                      hintStyle: style4,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 400),
                  child: TextField(
                    controller: _passwordController,
                    textAlign: TextAlign.left,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                    decoration: InputDecoration(
                      hintText: "Your password...",
                      hintStyle: style4,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ], // <-- Лишняя скобка была удалена отсюда
          ),
        ),
        const SizedBox(height: 120),
        Positioned(
          bottom: 70,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: isButtonActive ? 1.0 : 0.25,
            duration: const Duration(milliseconds: 300), // Сделал плавным, как у полей
            child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(220, 54),
                    ),
                    onPressed: () async {
                      if (isButtonActive && !_isLoading) {
                        await _handleLogin();
                      }
                    },
                    child: _isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                      ),
                    )
                        : Text(
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
