import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/core/router/routes.dart';
import 'package:svran_flutter_study/app/core/view_model/init_providers_view_model.dart';
import 'package:svran_flutter_study/app/ui/shared/app_theme.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

import '../public_code.dart';

void main() => runApp(MultiProvider(providers: providers, child: const App()));
// void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SvranSizeFit.init();
    return OKToast(
      animationBuilder: const Miui10AnimBuilder(),
      backgroundColor: Colors.black.withAlpha(0x99),
      textPadding: const EdgeInsets.all(15),
      position: ToastPosition.bottom,
      // dismissOtherOnShow: true,
      child: MaterialApp(
        // onUnknownRoute: AppRoutes.routes,
        onGenerateRoute: AppRoutes.generateRoute,
        routes: AppRoutes.routes,
        title: '梅屎光肠',
        initialRoute: AppRoutes.initialRoute,
        theme: AppTheme.normalTheme.copyWith(
          appBarTheme: kDebugMode ? AppBarTheme(color: randomColor()) : null,
        ),
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
