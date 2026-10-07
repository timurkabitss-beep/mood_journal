import 'package:flutter/material.dart';


//TODO допиши скролл а также логику изменения цвета и кнопка сохранения
class ThemeColorChoiceWidget extends StatefulWidget {
  const ThemeColorChoiceWidget({super.key});

  @override
  State<ThemeColorChoiceWidget> createState() => _ThemeColorChoiceWidgetState();
}

class _ThemeColorChoiceWidgetState extends State<ThemeColorChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0,4)
            )
          ]
      ),
    );
  }
}
