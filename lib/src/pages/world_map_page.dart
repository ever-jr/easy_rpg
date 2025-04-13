import 'package:easy_rpg/data/rpg_database.dart';
import 'package:easy_rpg/src/pages/character_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_rpg/src/components/map.dart';
import 'package:easy_rpg/src/components/search.dart';
import 'package:easy_rpg/src/components/buttons/square_button.dart';
import 'package:easy_rpg/src/pages/chat_page.dart';
import 'package:easy_rpg/src/pages/items_page.dart';
import 'package:easy_rpg/src/components/player/buttons_abilities.dart';
import 'package:easy_rpg/src/settings/settings_view.dart';


class WorldMapPage extends StatelessWidget {
  static const routeName = '/home';
  static const double _padding = 16;

  final GridMap map;

  const WorldMapPage({required this.map, super.key});

  @override
  Widget build(BuildContext context) {
    final middleScreenButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SquareButton(
              Icons.list,
              onPressed: () {
                //Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox(height: _padding),
            const SquareButton(Icons.square_rounded),
          ],
        ),
        Column(
          children: [
            SquareButton(
              Icons.chat,
              onPressed: () {
                Navigator.restorablePushNamed(
                  context,
                  ChatPage.routeName,
                );
              },
            ),
            const SizedBox(height: _padding),
            SquareButton(
              Icons.book,
              onPressed: () {
                Navigator.restorablePushNamed(context, CharacterPage.routeName);
              },
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchThings(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: _padding),
        ],
      ),
      drawer: const HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            InteractiveViewer(
              boundaryMargin: EdgeInsets.all(map.realSize.height),
              constrained: true,
              child: Center(
                child: map,
                //child: _DatabaseTest(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                middleScreenButtons,
                const Spacer(flex: 1),
                const ButtonsAbilities(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  static const double _padding = 24.0;
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: _padding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.book),
                label: const Text('Campaign'),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_box),
                label: const Text('Items'),
                onPressed: () {
                  Navigator.restorablePushNamed(context, ItemsPage.routeName);
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Characters'),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Maps'),
                onPressed: () {},
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.settings),
                label: const Text('Settings'),
                onPressed: () {
                  Navigator.restorablePushNamed(
                    context,
                    SettingsView.routeName,
                  );
                },
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Leave Campaign'),
                onPressed: () {},
              ),
              const SizedBox(height: _padding),
            ],
          ),
        ],
      ),
    );
  }
}

class _DatabaseTest extends StatefulWidget {
  const _DatabaseTest();

  @override
  State<_DatabaseTest> createState() => _DatabaseTestState();
}

class _DatabaseTestState extends State<_DatabaseTest> {
  List<PlayerData>? players;

  @override
  void initState() {
    super.initState();

    RpgDatabase.fetchPlayersData().then((data) {
      setState(() {
        players = data;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return players == null
        ? const CircularProgressIndicator()
        : Text(players.toString());
  }
}