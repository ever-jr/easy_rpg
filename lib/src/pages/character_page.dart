import 'package:easy_rpg/src/settings/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterPage extends StatefulWidget {
  static const String routeName = '/character';

  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final iconController = TextEditingController();
  final nameController = TextEditingController();
  final levelController = TextEditingController();
  final playerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    iconController.text = "💀";
    nameController.text = "Skull Schoolar";
    levelController.text = "1";
    playerController.text = "Little Jonas";

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () {},
            label: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            color: ColorPalette.lessDark,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 12.0,
              children: [
                SheetInput(
                  title: "Icon",
                  controller: iconController,
                  width: 100,
                  textAlign: TextAlign.center,
                ),
                SheetInput(
                  title: "Name",
                  controller: nameController,
                  width: 480,
                ),
                SheetInput(
                  title: "Level",
                  controller: levelController,
                  width: 100,
                  textAlign: TextAlign.center,
                ),
                SheetInput(
                  title: "Player",
                  controller: playerController,
                  width: 480,
                ),
                const SheetAddInputButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SheetInput extends StatelessWidget {
  static const double _padding = 8.0;

  final String title;
  final TextEditingController controller;
  final double width;
  final TextAlign textAlign;

  const SheetInput({
    super.key,
    required this.title,
    required this.controller,
    this.width = double.infinity,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _padding),
          child: Text(
            title,
            style: const TextStyle(color: ColorPalette.light),
          ),
        ),
        SizedBox(
          width: width,
          child: Card(
            color: ColorPalette.dark,
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: TextField(
                controller: controller,
                textAlign: textAlign,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class SheetAddInputButton extends StatelessWidget {
  const SheetAddInputButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: ColorPalette.light,
          foregroundColor: ColorPalette.lessDark,
          minimumSize: const Size.fromHeight(64),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
