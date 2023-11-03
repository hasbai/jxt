import 'package:flutter/material.dart';

import 'about.dart';
import 'laundry/main.dart';

enum Pages {
  laundry,
  about,
}

const Map<Pages, String> pageNames = {
  Pages.laundry: 'Laundry',
  Pages.about: 'About',
};

const Map<Pages, Widget> pages = {
  Pages.laundry: Laundry(),
  Pages.about: About(),
};

const tokenNames = {
  Pages.laundry: 'laundry_token',
};

final snackbarKey = GlobalKey<ScaffoldMessengerState>();

final Map<Pages, GlobalKey<NavigatorState>> navigatorKeys = {
  Pages.laundry: GlobalKey<NavigatorState>(),
  Pages.about: GlobalKey<NavigatorState>(),
};
