import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/router/routes.dart';
import 'package:svran_flutter_study/study/router/about_page.dart';
import 'package:svran_flutter_study/study/router/detail_page.dart';
import 'package:svran_flutter_study/study/router/un_know_page.dart';

class SvranRouter {
  static Map<String, WidgetBuilder> get routes {
    _routes.addAll(AppRoutes.routes);
    _routes.remove("/");
    return _routes;
  }

  static final Map<String, WidgetBuilder> _routes = {
    RouterAboutPage.routeName: (context) => const RouterAboutPage(),
  };

  static final RouteFactory generateRoute = (settings) {
    if (settings.name == RouterDetailPage.routeName) {
      return MaterialPageRoute(builder: (context) {
        return RouterDetailPage(
          message: settings.arguments as String,
        );
      });
    }
  };

  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(builder: (context) {
      return const RouterUnknownPage();
    });
  };
}
