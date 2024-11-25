import 'package:flutter/material.dart';

const squareSize = Size(100, 100);
const visionSize = Size(5, 5);

class GridMap extends StatelessWidget {
  final List<String> objects;

  const GridMap({
    super.key,
    required this.objects,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: squareSize.width * visionSize.width,
        height: squareSize.height * visionSize.height,
        child: Wrap(
          children: List.generate(
            objects.length,
            (i) => MapElement(icon: objects[i]),
          ),
        ),
      ),
    );
  }
}

class MapElement extends StatelessWidget {
  final String icon;
  const MapElement({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0x87a69eff);
    const shape = WidgetStatePropertyAll(RoundedRectangleBorder());
    const borders = WidgetStatePropertyAll(BorderSide(color: borderColor));

    return SizedBox.fromSize(
      size: squareSize,
      child: TextButton(
        style: const ButtonStyle(shape: shape, side: borders),
        onPressed: () => {},
        child: Text(icon),
      ),
    );
  }
}