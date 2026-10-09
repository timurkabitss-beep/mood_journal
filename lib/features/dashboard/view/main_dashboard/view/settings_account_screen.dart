import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/state/global_state.dart';
import '../../../../../features/dashboard/view/main_dashboard/view/steps/widgets/settings_screen_widgets/personal_info_widget.dart';
import '../../../../../features/dashboard/view/main_dashboard/view/steps/widgets/settings_screen_widgets/theme_color_choice_widget.dart';
import '../../../../../ui/fonts/all_fonts.dart';

class SettingsAccountScreen extends StatefulWidget {
  const SettingsAccountScreen({super.key});

  @override
  State<SettingsAccountScreen> createState() => _SettingsAccountScreenState();
}

class _SettingsAccountScreenState extends State<SettingsAccountScreen> {
  final ScrollController _scrollController = ScrollController();
  // Флаг для отображения кнопки сохранения
  bool _showSaveButton = false;

  final GlobalKey<PersonalInfoWidgetState> _personalInfoKey = GlobalKey<PersonalInfoWidgetState>();

  @override
  void dispose() {
    _scrollController.dispose(); ;
    super.dispose();
  }

  void _onDataChanged(bool hasChanges) {
    setState(() {
      _showSaveButton = hasChanges;
    });
  }

 void _onSaveRequested(String newName, String newEmail) {
    _showPasswordDialog(newName, newEmail);
  }

  void _showPasswordDialog(String newName, String newEmail) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      animationStyle: AnimationStyle(
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeIn,
      ),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Confirmation of the change",
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "To save the new data, enter your account password:",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              textAlign: TextAlign.center,
              obscureText: true,
              style: style_cursor,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey.shade500),
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
                    backgroundColor: Colors.green

                  ),
                  onPressed: () {
                    // PLACEHOLDER: replace with a real password check from your AppState or Firebase
                    final isCorrect = passwordController.text == "12345";

                    if (isCorrect) {
                      Navigator.pop(context); // Close the dialog

                      // Call the child widget method so it updates its "original" values
                      // and hides the save button
                      _personalInfoKey.currentState?.confirmSave();

                      // You can add real saving to AppState here if confirmSave doesn't do it
                      // context.read<AppState>().updateUserProfile(newName, newEmail);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Data updated successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Incorrect password"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text("SAVE", style: style5.copyWith(color: Colors.white)),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text("CANCEL", style: style5.copyWith(color: Colors.white),),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalInfoWidget(
                    key: _personalInfoKey,
                    onHasChanged: _onDataChanged,
                    onSaveRequested: _onSaveRequested,
                  ),
                  const SizedBox(height: 20),
                  const ThemeColorChoiceWidget(),
                ],
              ),
            ),
          ),

          Positioned(
            top: 90,
            left: 20,
            child: GestureDetector(
              onTap: () => setCurrentIndex(3),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.grey, size: 30),
              ),
            ),
          ),

          if (_showSaveButton)
            Positioned(
              top: 90,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Сначала снимаем фокус с полей ввода, чтобы скрыть клавиатуру
                  FocusScope.of(context).unfocus();
                  _onSaveRequested("", ""); // Передаем пустые строки, реальные данные возьмет confirmSave
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.green, // Зеленый цвет для действия сохранения
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