import 'package:easy_rpg/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_rpg/screen/screens.dart';

class App extends StatelessWidget {
  static const String name = 'Easy RPG';
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: AppColors.primary,
        ),
      ),
      home: const Login(),
    );
  }
}
