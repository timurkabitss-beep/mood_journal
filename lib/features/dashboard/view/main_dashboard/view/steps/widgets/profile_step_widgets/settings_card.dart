import 'package:flutter/material.dart';
import 'package:mood_journal/ui/fonts/all_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/state/global_state.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final setCurrentIndex = context.read<AppState>().setCurrentIndex;
    return GestureDetector(
      onTap: (){
        setCurrentIndex(4);
      },
      child: Container(
        height: 100,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(  width: 20,),
              _widget(Icons.settings),
              const SizedBox(  width: 20,),
              Text("Settings", style: style_for_cards_name)
            ],
          ),
        ),
      ),
    );
  }

  Widget _widget(IconData icon){
    return Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey.shade300,
          ),
          child: Icon(icon, color: Colors.grey.shade600,),
    );
  }
}
