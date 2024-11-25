import 'package:flutter/material.dart';
import 'package:easy_rpg/src/components/buttons/square_button.dart';

class ButtonsAbilities extends StatelessWidget {
  static const double _padding = 16;
  const ButtonsAbilities({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SquareButton(Icons.star),
        SizedBox(width: _padding),
        SquareButton(Icons.star),
        SizedBox(width: _padding),
        SquareButton(Icons.star),
        SizedBox(width: _padding),
        SquareButton(Icons.star),
      ],
    );
  }
}
