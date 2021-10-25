import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/detail/detail.dart';
import 'package:svran_flutter_study/app/ui/pages/filter/filter.dart';
import 'package:svran_flutter_study/app/ui/pages/main/main.dart';
import 'package:svran_flutter_study/app/ui/pages/meal/meal.dart';
import 'package:svran_flutter_study/study/router/svran_router.dart';

class AppRoutes {
  static const initialRoute = SvranMainScreen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    SvranMainScreen.routeName: (context) => const SvranMainScreen(),
    SvranMealScreen.routeName: (context) => const SvranMealScreen(),
    SvranDetailScreen.routeName: (context) => const SvranDetailScreen(),
  };

  static final RouteFactory generateRoute = (RouteSettings settings) {
    if (settings.name == SvranFilterScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) {
          return SvranFilterScreen();
        },
        fullscreenDialog: true,
      );
    }
  };

  static final RouteFactory unknownRoute = (RouteSettings settings) {
    return null;
  };
}
