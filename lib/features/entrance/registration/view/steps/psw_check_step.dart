import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/fonts/font.dart';
import 'package:provider/provider.dart';
import 'package:mood_journal/core/data/repositories/auth_repository.dart'; // (или твой путь)
class PswCheckStep extends StatefulWidget {
  const PswCheckStep({super.key,});

  @override
  State<PswCheckStep> createState() => _PswCheckStepState();
}

class _PswCheckStepState extends State<PswCheckStep> {
  bool _isPswValid = false;
  bool _isPswMatch = false;
  double _opacity = 0.0;
  String _passwordError = '';

  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  @override
  void dispose(){
    _passwordController1.dispose();
    _passwordController2.dispose();
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
    _passwordController1.addListener(_validatePassword);
    _passwordController2.addListener(_validatePassword);
  }

  void _validatePassword(){
    final password1 = _passwordController1.text;
    final password2 = _passwordController2.text;

    final passwordRegExp = RegExp(
        r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9!@#$%^*_+=\-./?|~()\[\]{},]{8,64}$'
    );

    final bool isValidFormat = passwordRegExp.hasMatch(password1);
    final bool isMatch = password1 == password2 && password2.isNotEmpty;

    // Определяем текст ошибки
    String errorMessage = '';
    if (password1.isNotEmpty) {
      if (!isValidFormat) {
        // Проверяем, какое именно правило нарушено
        if (password1.length < 8) {
          errorMessage = 'Minimum 8 characters';
        } else if (!password1.contains(RegExp(r'[a-zA-Z]'))) {
          errorMessage = 'Must contain at least one letter';
        } else if (!password1.contains(RegExp(r'\d'))) {
          errorMessage = 'Must contain at least one digit';
        } else if (password1.contains(RegExp(r"""['";\\<>&]"""))) {
          errorMessage = 'Forbidden characters: \' " ; \\ < > &';
        } else {
          errorMessage = 'Invalid password format';
        }
      } else if (!isMatch && password2.isNotEmpty) {
        errorMessage = 'Passwords do not match';
      }
    }

    if (errorMessage != _passwordError || isValidFormat != _isPswValid || isMatch != _isPswMatch){
      setState(() {
        _passwordError = errorMessage;
        _isPswValid = isValidFormat;
        _isPswMatch = isMatch;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final onboardProvider = context.watch<AppState>();
    final currentTheme = onboardProvider.selectedTheme;
    final bool isButtonActive = _isPswValid && _isPswMatch;

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
                  "Create a strong password!",
                  textAlign: TextAlign.center,
                  style: style3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:  Text(
                  "Think carefully.",
                  textAlign: TextAlign.center,
                  style: style1,
                ),
              ),
              const SizedBox(height: 160,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:
                TextField(
                    controller: _passwordController1,
                    textAlign: TextAlign.left,
                    obscureText: true,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    decoration: InputDecoration(
                        hintText: "Password...",
                        hintStyle: style4,
                        errorText: _passwordError.isNotEmpty ? _passwordError : null, //  Показываем ошибку
                        errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 13),
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
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child:
                TextField(
                    controller: _passwordController2,
                    textAlign: TextAlign.left,
                    obscureText: true,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                    decoration: InputDecoration(
                        hintText: "Confirm password...",
                        hintStyle: style4,
                        errorText: _passwordError.isNotEmpty && _passwordController2.text.isNotEmpty
                            ? _passwordError
                            : null, //  Показываем ошибку только если второе поле заполнено
                        errorStyle: TextStyle(color: Colors.red.shade300, fontSize: 13),
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
                  if(isButtonActive){
                    final authRepo = AuthRepository();

                    final isAlreadyRegistered = await authRepo.isUserRegistered();

                    if (isAlreadyRegistered) {
                      // Прерываем выполнение и показываем красивую ошибку
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('An account is already registered on this device!'),
                          backgroundColor: Colors.red.shade400,
                          behavior: SnackBarBehavior.floating, // Чтобы красиво смотрелось поверх UI
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      );
                      return; // Выходим из функции, сохранение не произойдет
                    }


                    final email = context.read<AppState>().userEmail;
                    final password = _passwordController1.text;

                    await authRepo.saveCredentials(email, password);
                    if (mounted){
                      Navigator.of(context).pushNamedAndRemoveUntil('/main_dashboard_screen', (route) => false);
                    }
                  }
                },
                child: Text(
                  "FINISH IT",
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
