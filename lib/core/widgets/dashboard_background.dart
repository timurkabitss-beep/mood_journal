import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';

class DashboardBackground extends StatelessWidget {
  const DashboardBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppState>().selectedTheme;

    return CustomPaint(
      painter: CurvePainter(themeColors: theme.colors),
    );
  }
}

class CurvePainter extends CustomPainter {
  final List<Color> themeColors;

  CurvePainter({required this.themeColors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: themeColors.length > 1
            ? [themeColors[0], themeColors[1]]
            : [themeColors[0], themeColors[0]],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Начинаем с левого края (на 20% высоты)
    path.moveTo(0, size.height * 1.2);

    // Одна выпуклая кривая через центр (опускается до 50% высоты)
    path.quadraticBezierTo(
      size.width * 0.5,   // контрольная точка по центру
      size.height * 1.5,  // опускаем вниз (выпуклость)
      size.width,         // правый край
      size.height * 1.2,  // та же высота, что и слева
    );

    // Замыкаем путь вверх
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}