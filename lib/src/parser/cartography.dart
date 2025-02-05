import 'package:easy_rpg/src/math/math.dart';


class MapElementData {
  static const String _emptyName = "Empty";

  final String? icon;
  final String name;
  Vector2 position;

  MapElementData({
    this.icon,
    this.name = _emptyName,
    required this.position,
    });

  static bool isValid(Map<String, Object>? object) {
    if (object == null) {
      return false;
    }

    return object.containsKey("position");
  }

  factory MapElementData.fromJson(Map<String, Object> object) {
    String? icon;
    String? name;
    final Vector2 position;

    if (!(object.containsKey("position") && object["position"] is List<int>)) {
      position = Vector2();
    } else {
      final positionAsList = object["position"] as List<int>;

      position = Vector2(
        x: positionAsList[0],
        y: positionAsList[1],
      );
    }

    if (object.containsKey("icon")) {
      icon = object["icon"] as String;
    }

    if (object.containsKey("name")) {
      name = object["name"] as String;
    }

    return MapElementData(
      icon: icon,
      name: name ?? _emptyName,
      position: position,
    );
  }
}

const mapExample = [
  {
    "icon": "🌳",
    "name": "Tree",
    "position": [-1, -1]
  },
  {
    "icon": "🌳",
    "name": "Tree",
    "position": [-2, 0]
  },
  {
    "icon": "🌳",
    "name": "Tree",
    "position": [1, 1]
  },
  {
    "icon": "💀",
    "name": "Enemy",
    "position": [0, 0]
  },
  {
    "icon": "⛪",
    "name": "Tree",
    "position": [3, 0]
  },
];

class Cartography {
  const Cartography._();

  static List<MapElementData> dataIntoList(final List<Map<String, Object>> data) {
    final List<MapElementData> elementsList = [];

    for (final element in data) {
      if (MapElementData.isValid(element)) {
        final data = MapElementData.fromJson(element);
        elementsList.add(data);
      }
    }

    return elementsList;
  }

  static void dataIntoMap() {}
}