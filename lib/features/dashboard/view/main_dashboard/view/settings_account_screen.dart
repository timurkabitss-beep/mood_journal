import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/steps/widgets/settings_screen_widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../../core/state/global_state.dart';

class SettingsAccountScreen extends StatefulWidget {
  const SettingsAccountScreen({super.key});

  @override
  State<SettingsAccountScreen> createState() => _SettingsAccountScreenState();
}

class _SettingsAccountScreenState extends State<SettingsAccountScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController;
  }

  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalInfoWidget(),
                  const SizedBox(height: 20,),
                  ThemeColorChoiceWidget(),
                ],
              ),
            ),
          ),
          Positioned(
              top: 90,
              left: 20,
              child: GestureDetector(
                onTap: (){
                  setCurrentIndex(3);
                },
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
                            offset: const Offset(0,4)
                        )
                      ]
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.grey.shade600,),
                ),
              )
          ),
        ],
      )
    );
  }
}
