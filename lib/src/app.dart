import 'package:easy_rpg/models/player.dart';
import 'package:easy_rpg/src/components/map.dart';
import 'package:easy_rpg/src/data/character_properties.dart';
import 'package:easy_rpg/src/pages/character_page.dart';
import 'package:easy_rpg/src/pages/chat_page.dart';
import 'package:easy_rpg/src/pages/login_page.dart';
import 'package:easy_rpg/src/pages/world_map_page.dart';
import 'package:easy_rpg/src/pages/items_page.dart';
import 'package:easy_rpg/src/parser/cartography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    required this.characterProperties,
  });

  final SettingsController settingsController;

  final CharacterProperties characterProperties;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final playerNotifier = PlayerNotifier();

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          debugShowCheckedModeBanner: false,

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case ChatPage.routeName:
                    return const ChatPage();

                  case ItemsPage.routeName:
                    return const ItemsPage();

                  case CharacterPage.routeName:
                    return CharacterPage(
                        characterProperties: widget.characterProperties);

                  case SettingsView.routeName:
                    return SettingsView(controller: widget.settingsController);

                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();

                  case SampleItemListView.routeName:
                  case WorldMapPage.routeName:
                  default:
                    return ListenableBuilder(
                      listenable: playerNotifier,
                      builder: (BuildContext context, Widget? child) {
                        if (!playerNotifier.isLoggedIn) {
                          return LoginPage(playerNotifier: playerNotifier);
                        }

                        return WorldMapPage(
                          map: GridMap(
                            elements: Cartography.dataIntoList(mapExample),
                          ),
                        );
                      },
                    );
                }
              },
            );
          },
        );
      },
    );
  }
}
