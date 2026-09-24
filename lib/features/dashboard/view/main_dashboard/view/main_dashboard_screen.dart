import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/steps.dart';
import 'package:provider/provider.dart';


class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _steps =  [
    const MainStep(),
    const Center(child: Text('Quotes Step', style: TextStyle(color: Colors.white70))), // 1: Цитаты
    const AnalyticsStep(),// 2: Статистика
    const Center(child: Text('Profile Step', style: TextStyle(color: Colors.white70))),// 3: Профиль
  ];

  void _onItemTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    // Вычисляем базовую высоту панели меню без учета системной полосы жестов
    const double baseMenuHeight = 70.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Positioned.fill(
            child: EasyAnimatedIndexedStack(
              duration: Duration(milliseconds: 500),
              index: _currentIndex,
              curve:  Curves.easeInOutCubic,
              children: _steps,
            )
          ),
          //НИЖНЕЕ МЕНЮ
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 90 + bottomPadding,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: bottomPadding,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildMenuIcon(Icons.wb_sunny_outlined, 0),
                    const SizedBox(width: 20),
                    _buildMenuIcon(Icons.format_quote_outlined, 1),
                    const Spacer(),
                    _buildMenuIcon(Icons.show_chart_rounded, 2),
                    const SizedBox(width: 20),
                    _buildMenuIcon(Icons.emoji_people_outlined, 3),
                  ],
                ),
              ),
            ),
          ),

          //  ПЛАВАЮЩАЯ КНОПКА "+"
          Positioned(
            bottom: bottomPadding + 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/check_in_flow_screen");
                },
                child: Container(
                  width: 70,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: currentTheme.colors,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMenuIcon(IconData icon, int index) {
    final bool isSelected = _currentIndex == index;

    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Colors.black : Colors.black38,
        size: 30,
      ),
      onPressed: () => _onItemTapped(index),
    );
  }
}
