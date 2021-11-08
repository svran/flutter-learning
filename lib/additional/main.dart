import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/toast/miui_10_anim_builder.dart';

import '../public_code.dart';

// void main() => runApp(MultiProvider(providers: providers, child: const App()));
void main() => runApp(const AdditionalApp());

class AdditionalApp extends StatelessWidget {
  const AdditionalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SvranSizeFit.init();
    return OKToast(
      animationBuilder: const SvranMiui10AnimBuilder(),
      backgroundColor: Colors.black.withAlpha(0x99),
      textPadding: const EdgeInsets.all(15),
      position: ToastPosition.bottom,
      // dismissOtherOnShow: true,
      child: MaterialApp(
        // onUnknownRoute: AppRoutes.routes,
        title: 'CreateBySvran',
        theme: ThemeData(
          appBarTheme: kDebugMode ? AppBarTheme(color: randomColor()) : null,
        ),
        supportedLocales: const [Locale("zh")],
        localizationsDelegates: const [
          // 国际化支持语言包
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: Scaffold(
          appBar: AppBar(title: const Text('CreateBySvran')),
          body: Center(
            child: Container(
              color: Colors.red.withOpacity(0.3),
              // child: Webview(WebviewController()),
            ),
          ),
        ),
      ),
    );
  }
}
