import 'package:flutter/material.dart';
import 'package:mood_journal/core/data/repositories/auth_repository.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/widgets/widgets.dart';
import '../../../../../../core/widgets/dashboard_background.dart';


class ProfileStep extends StatefulWidget {
  const ProfileStep({super.key});

  @override
  State<ProfileStep> createState() => _ProfileStepState();
}

class _ProfileStepState extends State<ProfileStep> {
  final AuthRepository _authRepo = AuthRepository();

  bool _isLoggingOut = false;

  Future<void> _handleLogout()async{
    setState(() {
      _isLoggingOut = true;
    });
    try{
      await _authRepo.logout();
    } catch (e){
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при выходе: $e')),
        );
      }
    } finally{
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            color: Colors.white,
            child: ElevatedButton(
              // Блокируем кнопку во время выхода
              onPressed: _isLoggingOut ? null : _handleLogout,
              child: _isLoggingOut
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text(
                "EXIT",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(220, 54),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
