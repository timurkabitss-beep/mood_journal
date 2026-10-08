import 'package:flutter/material.dart';

import '../../../../../../../../ui/fonts/all_fonts.dart';

class PersonalInfoWidget extends StatefulWidget {
  const PersonalInfoWidget({super.key});

  @override
  State<PersonalInfoWidget> createState() => _PersonalInfoWidgetState();
}

class _PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
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
            child: TextField(
              controller: _nameController,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87, fontSize: 22), // Тёмный текст
              cursorColor: Colors.black, // Видимый курсор
              decoration: InputDecoration(
                hintText: "What should I call you?",
                hintStyle: TextStyle(color: Colors.grey.shade500), // Серая подсказка
                filled: true,
                fillColor: Colors.grey.shade100, // Лёгкий серый фон поля
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: _nameController,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87, fontSize: 22), // Тёмный текст
              cursorColor: Colors.black, // Видимый курсор
              decoration: InputDecoration(
                hintText: "What should I call you?",
                hintStyle: TextStyle(color: Colors.grey.shade500), // Серая подсказка
                filled: true,
                fillColor: Colors.grey.shade100, // Лёгкий серый фон поля
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
