import 'package:easy_rpg/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  static const double _fontSize = 30;
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: Row(
            children: [
              Text(
                'E',
                style: TextStyle(fontSize: _fontSize),
              ),
              Text(
                'asy',
                style: TextStyle(fontSize: _fontSize, color: Colors.black38),
              ),
            ],
          ),
        ),
        Text(
          'RPG',
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
