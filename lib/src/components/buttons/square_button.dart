import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  static const double _size = 56;

  final IconData _icon;
  final Function()? _onPressed;

  const SquareButton(
    IconData icon, {
    super.key,
    Function()? onPressed,
  })  : _icon = icon,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: _onPressed,
      child: SizedBox(
        width: _size,
        height: _size,
        child: Center(child: Icon(_icon)),
      ),
    );
  }
}
