import 'package:easy_rpg/controllers/controller_page.dart';
import 'package:easy_rpg/widgets/main_screen_navigation_bar.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerPage.instance;

    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) => controller.page,
      ),
      bottomNavigationBar: const MainScreenNavigationBar(),
    );
  }
}
