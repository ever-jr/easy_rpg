import 'package:flutter/material.dart';
import 'package:easy_rpg/screen/screens.dart';

import 'app_colors.dart';
import 'app_routes.dart';

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
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.home: (context) => const Home(),
        AppRoutes.login: (context) => const Login(),
      },
      initialRoute: AppRoutes.home,
    );
  }
}
