import 'package:easy_rpg/controllers/controller_page.dart';
import 'package:flutter/material.dart';

class MainScreenNavigationBar extends StatefulWidget {
  const MainScreenNavigationBar({super.key});

  @override
  State<MainScreenNavigationBar> createState() =>
      _MainScreenNavigationBarState();
}

class _MainScreenNavigationBarState extends State<MainScreenNavigationBar> {
  int currentIndex = 1;

  void onTap(int index) {
    final Pages page = switch (index) {
      0 => Pages.characters,
      2 => Pages.profile,
      _ => Pages.campaigns,
    };

    setState(() {
      currentIndex = index;
    });
    ControllerPage.instance.changeCurrentPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          label: 'Characters',
          icon: Icon(Icons.person_4),
        ),
        BottomNavigationBarItem(
          label: 'Campaigns',
          icon: Icon(Icons.home_max),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
