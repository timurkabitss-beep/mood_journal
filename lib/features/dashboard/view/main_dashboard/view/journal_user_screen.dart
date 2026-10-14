import 'package:flutter/material.dart';
import 'package:mood_journal/core/data/repositories/auth_repository.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/journal_screen_widgets/mood_entry_widget.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/journal_screen_widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../../core/state/global_state.dart';
import '../../../../../ui/fonts/all_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';


class JournalUserScreen extends StatefulWidget {
  const JournalUserScreen({super.key});

  @override
  State<JournalUserScreen> createState() => _JournalUserScreenState();
}

class _JournalUserScreenState extends State<JournalUserScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme;
    final setCurrentIndex = context.read<AppState>().setCurrentIndex;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double baseMenuHeight = 70.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 130 + MediaQuery.of(context).padding.top,
                left: 20,
                right: 20,
                bottom: baseMenuHeight + bottomPadding + 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 60,),
                      Text(
                        "Your journal",
                        textAlign: TextAlign.center,
                        style: style.copyWith(color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  InfoJournalWidget(),
                  const SizedBox(height: 20),
                  MoodEntryWidget(),

                ],
              ),
            ),
          ),

          Positioned(
            top: 90,
            left: 20,
            child: GestureDetector(
              onTap: () => setCurrentIndex(3),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.grey, size: 30),
              ),
            ),
          ),

        ],
      )
    );
  }
}
