import 'dart:ui';

import 'package:mood_journal/core/repositories/dashboard_state.dart';
import 'package:flutter/material.dart';
import '../abstract_dashboard_repository.dart';

class SecondDashboardRepository implements AbstractDashboardRepository{
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
            ? "Beautiful work, $userName! Keep that energy flowing!"
            : "Ready to make it official? Time to create your account!",
        secondText: isFirstLaunch
            ? const TextSpan(
            text: "Your emotions have a home here. Swing by whenever you need to pause, reflect, or just let it all out. I've got you.")
            : TextSpan(
          text: "You'll get cloud backups, device syncing, and your journal stays safe no matter what. Ready? Hit that ",
          children: [
            const TextSpan(
              text: "human icon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const TextSpan(text: " down there to get started."),
          ],
        ),
        targetRoute: '/registration_screen'
    );
  }
}