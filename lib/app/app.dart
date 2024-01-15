import 'package:easy_rpg/screen/screen_main.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const name = 'Easy RPG';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const ScreenMain(),
    );
  }
}
