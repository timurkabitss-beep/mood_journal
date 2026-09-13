import 'package:flutter/material.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import '../../../../ui/fonts/all_fonts.dart';


class BackgroundChoiceStep extends StatefulWidget {
  final String userName;
  // Колбэк, который на каждый тап по кругу будет менять цвет градиента в родителе
  final Function(AppThemeModel) onThemeChanged;
  // Финальный колбэк, который сработает при нажатии на SAVE
  final VoidCallback onSave;

  const BackgroundChoiceStep({
    super.key,
    required this.userName,
    required this.onThemeChanged,
    required this.onSave,
  });

  @override
  State<BackgroundChoiceStep> createState() => _BackgroundChoiceStepState();
}

class _BackgroundChoiceStepState extends State<BackgroundChoiceStep> {
  // На старте берем первую тему из списка
  late AppThemeModel _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = backThemes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text(
              "Topics, ${widget.userName}!\n Which topic do you like?",
              textAlign: TextAlign.center,
              style: style3.copyWith(color: Colors.white),
            ),

            const SizedBox(height: 160),

            // Горизонтальная лента выбора тем
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: backThemes.map((theme) {
                  final isSelected = theme.id == _selectedTheme.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTheme = theme;
                      });
                      // Мгновенно отдаем тему наверх родительскому градиенту!
                      widget.onThemeChanged(theme);
                    },
                    child: AnimatedContainer(
                      height: 90,
                      width: 90,
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: theme.colors,
                        ),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 240),

            // ФИНАЛЬНАЯ КНОПКА SAVE
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _selectedTheme.colors[0],
                minimumSize: const Size(220, 54),
              ),
              onPressed: widget.onSave, // Отдаем триггер финала родителю
              child: Text(
                "SAVE",
                style: style5.copyWith(color: _selectedTheme.colors[0]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
