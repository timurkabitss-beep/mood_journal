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

  @override
  void initState() {
    super.initState();

    final appState = context.read<AppState>();

    _originalName = appState.userName;

    _nameController.text = _originalName;
    _emailController.text = appState.userEmail;

    // Почта только для чтения, поэтому следим только за именем
    _nameController.addListener(_checkChanges);
  }

  void _checkChanges(){
    final isDirty = _nameController.text.trim() != _originalName;
    widget.onHasChanged(isDirty);
  }

  @override
  void dispose() {
    _nameController.removeListener(_checkChanges);
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void confirmSave(){
    widget.onSaveRequested(_nameController.text.trim(), _emailController.text.trim());

    setState(() {
      _originalName = _nameController.text.trim();
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
                    // Почта только для чтения: так же выглядит, но серый текст
                    // и нельзя редактировать
                    TextField(
                      controller: _emailController,
                      readOnly: true,
                      showCursor: false,
                      textAlign: TextAlign.center,
                      style: style_cursor.copyWith(color: Colors.grey.shade600),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        filled: true,
                        fillColor: Colors.grey.shade100,
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