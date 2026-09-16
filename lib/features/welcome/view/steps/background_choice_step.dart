import 'package:flutter/material.dart';
import 'package:mood_journal/features/welcome/state/onboarding_state.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import '../../../../ui/fonts/all_fonts.dart';


class BackgroundChoiceStep extends StatefulWidget {

  const BackgroundChoiceStep({
    super.key,
  });

  @override
  State<BackgroundChoiceStep> createState() => _BackgroundChoiceStepState();
}

class _BackgroundChoiceStepState extends State<BackgroundChoiceStep> {

  @override
  Widget build(BuildContext context) {

    final onboardProvider = context.watch<OnboardingState>();
    final currentTheme = onboardProvider.selectedTheme;

    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text(
              "Topics, ${onboardProvider.userName}!\n Which topic do you like?",
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
                  final isSelected = theme.id == currentTheme.id;

                  return GestureDetector(
                    onTap: () {
                      context.read<OnboardingState>().setTheme(theme);
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

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: currentTheme.colors[0],
                minimumSize: const Size(220, 54),
              ),
              onPressed: () async {
                if(mounted){
                  Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);
                }
              },
              child: Text(
                "SAVE",
                style: style5.copyWith(color: currentTheme.colors[0]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
