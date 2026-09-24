import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../../core/widgets/dashboard_background.dart';

class MainStep extends StatefulWidget {
  const MainStep({super.key});

  @override
  State<MainStep> createState() => _MainStepState();
}

class _MainStepState extends State<MainStep> {
  final ScrollController _scrollController = ScrollController();
  final double _parallaxFactor = 0.3;

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final backgroundHeight = screenHeight * 0.33;
    final currentTheme = context.watch<AppState>().selectedTheme;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double baseMenuHeight = 70.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _scrollController,
            builder: (context, child) {
              final scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
              final parallaxOffset = scrollOffset * _parallaxFactor;

              return Positioned(
                top: -parallaxOffset,
                left: 0,
                right: 0,
                height: backgroundHeight + parallaxOffset,
                child: child!,
              );
            },
            child: const DashboardBackground(),
          ),

          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 60 + MediaQuery.of(context).padding.top,
                left: 20,
                right: 20,
                bottom: baseMenuHeight + bottomPadding + 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  WeekCalendarCard(
                    selectedDate: _selectedDate,
                    onDateSelected: (newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  DailyTaskCard(selectedDate: _selectedDate),
                  const SizedBox(height: 20),
                  ChallengeCard(selectedDate: _selectedDate),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
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
                    IconButton(
                      icon: const Icon(Icons.wb_sunny_outlined, color: Colors.black38, size: 30),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.format_quote_outlined, color: Colors.black38, size: 30),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.show_chart_rounded, color: Colors.black38, size: 30),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.emoji_people_outlined, color: Colors.black38, size: 30),
                      onPressed: () {

                      },
                    )
                  ],
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            bottom: bottomPadding + (65 - 65) / 2 + 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: (){
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
                        colors: currentTheme.colors
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}