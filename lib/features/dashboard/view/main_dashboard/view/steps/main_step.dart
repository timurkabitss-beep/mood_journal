import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/widgets/widgets.dart';
import '../../../../../../core/widgets/dashboard_background.dart';

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
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double baseMenuHeight = 70.0;

    return Stack(
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
        ],
    );
  }
}