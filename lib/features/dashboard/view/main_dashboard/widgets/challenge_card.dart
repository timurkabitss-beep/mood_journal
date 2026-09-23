import 'package:flutter/material.dart';
import 'package:mood_journal/core/state/global_state.dart';
import 'package:provider/provider.dart';

class ChallengeCard extends StatefulWidget {
  const ChallengeCard({super.key});

  @override
  State<ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {

    final currentTheme = context.watch<AppState>().selectedTheme;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 180,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: currentTheme.colors
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: (){

          },
          child: Stack(
            children: [
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flag, size: 20, color: Colors.white),
                      const SizedBox(width: 4),
                      ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                //   Text("ULULI", style: TextStyle(
                //       color: Colors.grey.shade600,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w600,)),
                // ],
              )
            ],
          ),
        )
    );
  }
}
