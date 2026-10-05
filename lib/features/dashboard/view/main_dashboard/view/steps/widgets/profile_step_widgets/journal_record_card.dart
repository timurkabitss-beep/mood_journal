import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalRecordCard extends StatelessWidget {
  const JournalRecordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

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
              _widget(Icons.book_outlined),
              const SizedBox(  width: 20,),
              Text("Your Journal", style: TextStyle(fontSize: 18, color: Colors.grey.shade600),)
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
