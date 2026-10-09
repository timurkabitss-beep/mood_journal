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
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text("Подтверждение изменений"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Для сохранения новых данных введите пароль от вашего аккаунта:"),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              textAlign: TextAlign.center,
              style: style_cursor, // Тёмный текст
              cursorColor: Colors.black, // Видимый курсор
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey.shade500), // Серая подсказка
                filled: true,
                fillColor: Colors.grey.shade100, // Лёгкий серый фон поля
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Отмена"),
            ),
              ElevatedButton(
                onPressed: () {
                  // ЗАГЛУШКА: Замени это на реальную проверку пароля из твоего AppState или Firebase
                  final isCorrect = passwordController.text == "12345";

                  if (isCorrect) {
                    Navigator.pop(context); // Закрываем диалог

                    // Вызываем метод дочернего виджета, чтобы он обновил свои "оригинальные" значения
                    // и скрыл кнопку сохранения
                    _personalInfoKey.currentState?.confirmSave();

                    // Здесь можно добавить реальное сохранение в AppState, если confirmSave этого не делает
                    // context.read<AppState>().updateUserProfile(newName, newEmail);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Данные успешно обновлены!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Неверный пароль"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("Сохранить"),
              ),
            ],
          )
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
                  // 4. ПЕРЕДАЕМ ВСЕ НЕОБХОДИМЫЕ ПАРАМЕТРЫ И КЛЮЧ
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

          // Кнопка "Назад" (слева)
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

          // 5. Кнопка "Сохранить" (справа) - появляется ТОЛЬКО если _showSaveButton == true
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