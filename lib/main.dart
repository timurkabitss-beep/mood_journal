import 'package:flutter/material.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'features/name/view/name_input_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: basicTheme,
      routes: routes,
      onGenerateRoute: (settings) {
        if (settings.name == '/name_input'){
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const NameInputScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child,);
              },
            transitionDuration: const Duration(milliseconds: 400)
          );
        }
      },
    ),
  );
}
