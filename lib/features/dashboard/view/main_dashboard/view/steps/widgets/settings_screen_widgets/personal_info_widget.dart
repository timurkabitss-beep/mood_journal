import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../core/state/global_state.dart';
import '../../../../../../../../ui/fonts/all_fonts.dart';

class PersonalInfoWidget extends StatefulWidget {
  final ValueChanged<bool> onHasChanged;
  final Function(String newName, String newEmail) onSaveRequested;

  const PersonalInfoWidget({
    super.key,
    required this.onHasChanged,
    required this.onSaveRequested
  });

  @override
  State<PersonalInfoWidget> createState() => PersonalInfoWidgetState();
}

class PersonalInfoWidgetState extends State<PersonalInfoWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late String _originalName;
  late String _originalEmail;

  @override
  void initState() {
    super.initState();

    final appState = context.read<AppState>();

    _originalName = appState.userName;
    _originalEmail =appState.userEmail;

    _nameController.text = _originalName;
    _emailController.text = _originalEmail;

    _nameController.addListener(_checkChanges);
    _emailController.addListener(_checkChanges);
  }

  void _checkChanges(){
    bool isDirty = _nameController.text.trim() != _originalName ||
        _emailController.text.trim() != _originalEmail;
    widget.onHasChanged(isDirty);
  }
  @override
  void dispose() {
    _nameController.removeListener(_checkChanges);
    _emailController.removeListener(_checkChanges);
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void confirmSave(){
    widget.onSaveRequested(_nameController.text.trim(), _emailController.text.trim());

    setState(() {
      _originalName = _nameController.text.trim();
      _originalEmail = _emailController.text.trim();
    });
    widget.onHasChanged(false);
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 280,
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
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                 Text("Name",
                     style: settings_widgets_style.copyWith(color: Colors.grey)
                   ),
                 ]
                ),
                TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  style: style_cursor, // Тёмный текст
                  cursorColor: Colors.black, // Видимый курсор
                  decoration: InputDecoration(
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
                const SizedBox(height: 20,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Email",
                        style: settings_widgets_style.copyWith(color: Colors.grey)
                      )
                    ]
                ),
                TextField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  style: style_cursor, // Тёмный текст
                  cursorColor: Colors.black, // Видимый курсор
                  decoration: InputDecoration(
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
              ]
            )
          ),
        ],
      ),
    );
  }
}
