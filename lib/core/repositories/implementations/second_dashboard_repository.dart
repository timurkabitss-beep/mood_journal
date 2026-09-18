import 'dart:ui';

import 'package:mood_journal/core/repositories/dashboard_state.dart';

import '../abstract_dashboard_repository.dart';
// TODO изменить текст и данные
class SecondDashboardRepository {
  final String userName;
  final List<Color> themeColor;


  const SecondDashboardRepository({
    required this.userName,
    required this.themeColor,
  });

  @override
  DashboardState loadDashboardState({required bool isFirstLaunch}){
    return DashboardState(
        userName: userName,
        themeColors: themeColor,
        firstText: isFirstLaunch
            ? "Okay, $userName, !"
            : "How are you doing today, $userName?",
        secondText: isFirstLaunch
            ? "Your mindful journey starts right now. I'm here to listen to your thoughts every single day."
            : "Take a moment to check in with yourself. Tap the button below to add your first mood entry!",
        targetRoute: '/check_in_flow_screen'
    );
  }
}