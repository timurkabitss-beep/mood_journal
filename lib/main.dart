import 'package:flutter/material.dart';
import 'package:mood_journal/features/welcome/state/onboarding_state.dart';
import 'package:mood_journal/routes/routes.dart';
import 'package:mood_journal/ui/theme/theme.dart';
import 'package:mood_journal/core/database/hive_initializer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiProvider(
        providers: [
            ChangeNotifierProvider(create: ((context) => OnboardingState())),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: basicTheme,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
    )
  );
}
