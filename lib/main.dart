import 'package:easy_rpg/src/data/character_properties.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  final initialCharacterProperties = CharacterProperties([
    CharacterProperty(name: "Level", value: 1),
    CharacterProperty(name: "Name", value: "Robert"),
    CharacterProperty(name: "Class", value: "Mage"),
    CharacterProperty(name: "Strength", value: 3),
    CharacterProperty(name: "Intelligence", value: 7),
  ]);

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
    settingsController: settingsController,
    characterProperties: initialCharacterProperties,
  ));
}
