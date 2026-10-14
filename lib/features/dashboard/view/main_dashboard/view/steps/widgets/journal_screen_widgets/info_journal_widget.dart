import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/state/global_state.dart';
import '../../../../../../../../ui/fonts/all_fonts.dart';

class InfoJournalWidget extends StatefulWidget {
  const InfoJournalWidget({super.key});

  @override
  State<InfoJournalWidget> createState() => _InfoJournalWidgetState();
}

class _InfoJournalWidgetState extends State<InfoJournalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0,4)
            )
          ]
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
