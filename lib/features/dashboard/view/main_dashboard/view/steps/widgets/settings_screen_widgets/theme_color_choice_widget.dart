import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/ui/theme/app_theme_model.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../ui/fonts/all_fonts.dart';

class ThemeColorChoiceWidget extends StatefulWidget {
  const ThemeColorChoiceWidget({super.key});

  @override
  State<ThemeColorChoiceWidget> createState() => _ThemeColorChoiceWidgetState();
}

class _ThemeColorChoiceWidgetState extends State<ThemeColorChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 250,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: currentTheme.colors
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0,4)
            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Text(
                "Choose your theme",
                style: settings_widgets_style,
              ),
            ],
          ),
          const SizedBox(height: 30,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.hardEdge,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: backThemes.map((theme){
                final isSelected = theme.id == currentTheme.id;
                return GestureDetector(
                  onTap: (){
                    context.read<AppState>().setTheme(theme);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 90,
                    width: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:  LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: theme.colors,
                      ),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 5
                      ),
                    ),
                    child: Center(
                      child: isSelected ?  Icon(Icons.check, color: Colors.white) : null,
                    ),
                  )
                );

              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
