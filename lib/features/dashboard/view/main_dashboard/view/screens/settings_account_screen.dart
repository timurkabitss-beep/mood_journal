import 'package:flutter/material.dart';
import 'package:mood_journal/core/data/repositories/auth_repository.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/database/repositories/mood_repository.dart';
import '../../../../../../core/state/global_state.dart';
import '../steps/widgets/settings_screen_widgets/personal_info_widget.dart';
import '../steps/widgets/settings_screen_widgets/theme_color_choice_widget.dart';
import '../../../../../../ui/fonts/all_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_journal/core/ai/mood_report_service.dart';
import 'package:mood_journal/core/database/cloud_sync_service.dart';

class SettingsAccountScreen extends StatefulWidget {
  const SettingsAccountScreen({super.key});

  @override
  State<SettingsAccountScreen> createState() => _SettingsAccountScreenState();
}

class _SettingsAccountScreenState extends State<SettingsAccountScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showSaveButton = false;

  final GlobalKey<PersonalInfoWidgetState> _personalInfoKey = GlobalKey<PersonalInfoWidgetState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Вызывается из дочернего виджета, когда текст в полях меняется
  void _onDataChanged(bool hasChanges) {
    setState(() {
      _showSaveButton = hasChanges;
    });
  }

  void _onSaveRequested(String newName, String newEmail) {
    context.read<AppState>().setName(newName);

    // Имя сохраняем в профиле Firebase, чтобы оно не терялось
    // после смены устройства или очистки данных
    FirebaseAuth.instance.currentUser
        ?.updateDisplayName(newName.trim())
        .catchError((Object e) {
      debugPrint('updateDisplayName error: $e');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Data updated successfully!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      animationStyle: const AnimationStyle(
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeIn,
      ),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Delete Account",
          textAlign: TextAlign.center,
          style: style_full_date.copyWith(color: Colors.red),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "This action cannot be undone. To confirm deletion, enter your password:",
              textAlign: TextAlign.center,
              style: style5,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              textAlign: TextAlign.center,
              obscureText: true,
              style: style_cursor,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Your password",
                hintStyle:style4.copyWith(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final password = passwordController.text;

                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Please enter your password",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.orange,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                      return;
                    }

                    // Всё нужное берём до await: после закрытия диалога
                    // его context уже недоступен
                    final messenger = ScaffoldMessenger.of(this.context);
                    final navigator = Navigator.of(this.context);
                    final appState = this.context.read<AppState>();

                    void showMessage(String text, Color color) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            text,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: color,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      );
                    }

                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null || user.email == null) {
                        throw FirebaseAuthException(code: 'no-current-user');
                      }

                      // 1. Проверяем пароль ДО удаления данных
                      await user.reauthenticateWithCredential(
                        EmailAuthProvider.credential(
                          email: user.email!,
                          password: password,
                        ),
                      );

                      // 2. Чистим облако, кэш отчётов и данные на устройстве
                      await CloudSyncService.instance.deleteAllUserData();
                      await MoodReportService.instance.clearCache();
                      await MoodRepository.instance.deleteLocalData();

                      // 3. Удаляем сам аккаунт
                      await AuthRepository.instance.deleteAccount(password);

                      navigator.pop(); // закрыть диалог
                      appState.clear();
                      showMessage("Account deleted successfully", Colors.green);
                      navigator.pushNamedAndRemoveUntil('/', (route) => false);
                    } on FirebaseAuthException catch (e) {
                      String errorMessage;
                      if (e.code == 'wrong-password' ||
                          e.code == 'invalid-credential') {
                        errorMessage = "Incorrect password. Please try again.";
                      } else if (e.code == 'too-many-requests') {
                        errorMessage = "Too many attempts. Please try again later.";
                      } else if (e.code == 'requires-recent-login') {
                        errorMessage =
                        "Please log out and log back in to delete your account.";
                      } else {
                        errorMessage = e.message ?? "Failed to delete account";
                      }
                      showMessage(errorMessage, Colors.red);
                    } catch (e) {
                      showMessage("Unexpected error occurred", Colors.red);
                    }
                  },
                  child: Text("DELETE", style: style5.copyWith(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text("CANCEL", style: style5.copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;
    final setCurrentIndex = context.read<AppState>().setCurrentIndex;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double baseMenuHeight = 70.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 130 + MediaQuery.of(context).padding.top,
                left: 20,
                right: 20,
                bottom: baseMenuHeight + bottomPadding + 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalInfoWidget(
                    key: _personalInfoKey,
                    onHasChanged: _onDataChanged,
                    onSaveRequested: _onSaveRequested,
                  ),
                  const SizedBox(height: 20),
                  const ThemeColorChoiceWidget(),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      await MoodRepository.instance.close();
                      await FirebaseAuth.instance.signOut();
                      context.read<AppState>().clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(220, 54),
                    ),
                    child: Text("SIGN OUT", style: style5.copyWith(color: currentTheme.colors[0])),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(220, 54),
                    ),
                    onPressed: _showDeleteAccountDialog,
                    child: Text("DELETE ACCOUNT", style: style5.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),

          // Кнопка "Назад"
          Positioned(
            top: 90,
            left: 20,
            child: _BackButton(onTap: () => setCurrentIndex(3)),
          ),

          // Кнопка "Сохранить" (Зеленая галочка)
          if (_showSaveButton)
            Positioned(
              top: 90,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  // ЕДИНСТВЕННЫЙ вызов confirmSave.
                  // Он сам обратится к _onSaveRequested, а затем скроет эту кнопку через onHasChanged(false)
                  _personalInfoKey.currentState?.confirmSave();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 35),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9FB3CC).withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back, color: Colors.grey, size: 30),
      ),
    );
  }
}