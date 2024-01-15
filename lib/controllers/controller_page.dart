import 'package:easy_rpg/pages/page_campaigns.dart';
import 'package:easy_rpg/pages/page_characters.dart';
import 'package:easy_rpg/pages/page_profile.dart';
import 'package:flutter/material.dart';

enum Pages { characters, campaigns, profile }

final class ControllerPage extends ChangeNotifier {
  static final instance = ControllerPage._();

  ControllerPage._();

  Pages _page = Pages.campaigns;

  Widget get page => switch (_page) {
        Pages.characters => const PageCharacters(),
        Pages.campaigns => const PageCampaigns(),
        Pages.profile => const PageProfile(),
      };

  void changeCurrentPage(Pages page) {
    _page = page;
    notifyListeners();
  }
}
