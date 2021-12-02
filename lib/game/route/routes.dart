import 'package:flutter/material.dart';
import 'package:svran_flutter_study/game/play/play_game.dart';

class GameRoute {
  static final Map<String, WidgetBuilder> routes = {
    SvranPlayPage.routeName: (context) => const SvranPlayPage(),
  };
}
