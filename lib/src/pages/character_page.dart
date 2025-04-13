import 'package:easy_rpg/src/data/character_properties.dart';
import 'package:easy_rpg/src/settings/color_palette.dart';
import 'package:flutter/material.dart';

const characterSheetData = {
  "type": "sheet",
  "content": [
    {
      "name": "level",
      "type": "number",
      "size": 0,
      "value": 1
    },
    {
      "name": "class",
      "type": "text",
      "size": 1,
      "value": "warrior"
    },

    {
      "name": "health",
      "type": "text",
      "size": 1,
      "value": 9
    },

    {
      "name": "max_health",
      "type": "text",
      "size": 1,
      "value": 10
    },

    {
      "name": "health_bar",
      "type": "text",
      "size": 1,
      "value": "{health}/{max_health}",
      "readonly": true
    },

    {
      "name": "dexterity",
      "type": "number",
      "size": 0,
      "value": 12
    },
    {
      "name": "strength",
      "type": "number",
      "size": 0,
      "value": 8
    },
    {
      "name": "intelligence",
      "type": "number",
      "size": 0,
      "value": 16 
    },
  ]
};


enum SheetInputType {
  small, medium, big
}

class CharacterPage extends StatefulWidget {
  static const String routeName = '/character';
  final CharacterProperties characterProperties;

  const CharacterPage({super.key, required this.characterProperties});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            label: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Switch(
                    value: isEditing,
                    onChanged: (bool newValue) {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                  Text(isEditing ? "Editing" : ""),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: ColorPalette.lessDark,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: !isEditing
                          ? _NormalCharacterSheet(properties: widget.characterProperties)
                          : Container(
                              color: Colors.red,
                              child: const Placeholder(),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NormalCharacterSheet extends StatelessWidget {
  final CharacterProperties properties;

  const _NormalCharacterSheet({required this.properties});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(properties.length, (int index) {
        final CharacterProperty prop = properties.at(index);
        return Padding(
          padding: EdgeInsets.only(
            right: index < properties.length - 1
              ? 8.0
              : 0.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${prop.name}: "),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                child: Card(
                  color: Colors.black38,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(prop.value.toString()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}