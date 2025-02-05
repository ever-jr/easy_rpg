import 'package:easy_rpg/src/parser/cartography.dart';
import 'package:flutter/material.dart';

const squareSize = Size(100, 100);
const visionSize = Size(5, 5);

class IntRange {
  int min;
  int max;

  IntRange({required this.min, required this.max});

  @override
  String toString() {
    return "min: $min, max: $max";
  }
}

/*
class GridMapSize {
  IntRange columns;
  IntRange rows;

  GridMapSize({ required this.columns, required this.rows });
}
*/

class GridMap extends StatelessWidget {
  final List<MapElementData> elements;

  const GridMap({
    super.key,
    required this.elements,
  });

  Size get size {
    final colSize = IntRange(min: 0, max: 0);
    final rowSize = IntRange(min: 0, max: 0);

    for (int i = 0; i < elements.length; i++) {
      final MapElementData e = elements[i];

      final int x = e.position.x;
      final int y = e.position.y;

      if (i == 0) {
        colSize.min = x;
        colSize.max = x;

        rowSize.min = y;
        rowSize.max = y;
        continue;
      }

      if (x < colSize.min) {
        colSize.min = x;
      }

      if (x > colSize.max) {
        colSize.max = x;
      }

      if (y < rowSize.min) {
        rowSize.min = y;
      }

      if (y > rowSize.max) {
        rowSize.max = y;
      }
    }

    final int numColumns = (colSize.max - colSize.min) + 1;
    final int numRows = (rowSize.max - rowSize.min) + 1;

    return Size(numColumns * squareSize.width, numRows * squareSize.height);
  }

  @override
  Widget build(BuildContext context) {
    final colSize = IntRange(min: 0, max: 0);
    final rowSize = IntRange(min: 0, max: 0);

    for (int i = 0; i < elements.length; i++) {
      final MapElementData e = elements[i];

      final int x = e.position.x;
      final int y = e.position.y;

      if (i == 0) {
        colSize.min = x;
        colSize.max = x;

        rowSize.min = y;
        rowSize.max = y;
        continue;
      }

      if (x < colSize.min) {
        colSize.min = x;
      }

      if (x > colSize.max) {
        colSize.max = x;
      }

      if (y < rowSize.min) {
        rowSize.min = y;
      }

      if (y > rowSize.max) {
        rowSize.max = y;
      }

      //print("x: " + x.toString() + ", y: " + y.toString());
    }

    // TODO: log nums in screen without print
    //print("\ncolumn: " + colSize.toString() + "\nrow: " + rowSize.toString());

    final int numColumns = (colSize.max - colSize.min) + 1;
    final int numRows = (rowSize.max - rowSize.min) + 1;

    //print("cols: $numColumns rows: $numRows");

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(numRows, (int row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(numColumns, (int col) {
            final int x = colSize.min + col;
            final int y = colSize.min + row + 1;

            //String icon = "️x: $x  y: $y";
            String icon = "";

            for (final MapElementData e in elements) {
              if (e.position.x == x && e.position.y == y && e.icon != null) {
                icon = e.icon!;
                break;
              }
            }

            return MapElement(icon: icon);
          }),
        );
      }),
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