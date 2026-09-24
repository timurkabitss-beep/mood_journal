import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';

class AnalyticsStep extends StatefulWidget {
  const AnalyticsStep({super.key});

  @override
  State<AnalyticsStep> createState() => _AnalyticsStepState();
}

class _AnalyticsStepState extends State<AnalyticsStep> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: currentTheme.colors,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Иконка графика
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.analytics_outlined,
                size: 64,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 32),
            // Надпись COMING SOON
            Text(
              'COMING SOON',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 12),
            // Подзаголовок
            Text(
              'Your analytics will appear here' ,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '(IN DEVELOPMENT)' ,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}