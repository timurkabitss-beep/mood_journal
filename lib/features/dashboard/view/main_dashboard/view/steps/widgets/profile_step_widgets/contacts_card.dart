import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../../core/state/global_state.dart';
import '../../../../../../../../ui/fonts/all_fonts.dart';

class ContactsCard extends StatelessWidget {
  const ContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppState>().selectedTheme.colors[0];
    return GestureDetector(
      onTap: () async{
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: 'moodora.help@outlook.com',
          queryParameters: {
            'subject': 'Question about the Moodora app',
          }
        );
      },
      child: Container(
        height: 70,
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
              _widget(Icons.messenger_outline_sharp, currentTheme),
              const SizedBox(  width: 20,),
              Text("Contact support", style: style_for_cards_name)
            ],
          ),
        ),
      ),
    );
  }

  Widget _widget(IconData icon, Color color){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Icon(icon, color: color),
    );
  }
}
