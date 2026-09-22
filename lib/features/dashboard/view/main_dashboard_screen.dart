import 'package:flutter/material.dart';
import 'package:mood_journal/core/repositories/implementations/main_dashboard_repository.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/dashboard_background.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  double _opacity = 0.0;

  final ScrollController _scrollController = ScrollController();
  final double _parallaxFactor = 0.65;

  @override
  void initState(){
    Future.delayed(Duration(milliseconds:500), (){
      if (mounted){
        setState(() {
          _opacity = 1.0;
        });
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final backgroundHeight = screenHeight * 0.33;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                final scrollOffset = _scrollController.hasClients
                    ? _scrollController.offset
                    : 0.0;
                final parallaxOffset = scrollOffset * _parallaxFactor;

                return Positioned(
                    top: -parallaxOffset,
                    left: 0,
                    right: 0,
                    height: backgroundHeight + parallaxOffset,
                    child: child!
                );
              },
              child: const DashboardBackground(),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController, // Привязываем контроллер!
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заглушки (потом заменим на реальные виджеты)
                  const Text("Today", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text("Tuesday, September 22", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 24),
                  Container(height: 80, color: Colors.white.withOpacity(0.2)), // Календарь

                  const SizedBox(height: 32),
                  Container(height: 140, color: Colors.white), // Карточка 1
                  const SizedBox(height: 16),
                  Container(height: 140, color: Colors.white), // Карточка 2

                  const SizedBox(height: 400), // Просто чтобы было куда скроллить
                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}
