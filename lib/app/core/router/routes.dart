import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/main/main.dart';

class AppRoutes {
  static const initialRoute = SvranMainScreen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    SvranMainScreen.routeName: (context) => const SvranMainScreen(),
  };

  static final RouteFactory generateRoute = (RouteSettings settings) {
    return null;
  };

  static final RouteFactory unknownRoute = (RouteSettings settings) {
    return null;
  };
}
