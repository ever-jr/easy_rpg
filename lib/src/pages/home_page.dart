import 'package:easy_rpg/src/components/search.dart';
import 'package:easy_rpg/src/pages/chat_page.dart';
import 'package:easy_rpg/src/pages/items_page.dart';
import 'package:easy_rpg/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

const objectsOnMap = [
  '😊',
  '😊',
  '😊',
  '🌳',
  '🌳',
  '🌳',
  '🌳',
  '🌳',
];

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  static const double _padding = 16;

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            const GridMap(objects: objectsOnMap),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                Row(
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
                        const SquareButton(Icons.book),
                      ],
                    ),
                  ],
                ),
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

class GridMap extends StatelessWidget {
  final List<String> objects;
  const GridMap({
    super.key,
    required this.objects,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(100),
      child: const Placeholder(),
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
