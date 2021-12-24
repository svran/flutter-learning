import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/toast/miui_10_anim_builder.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';
import 'package:svran_flutter_study/tb/pages/tb_list_page.dart';

import '../public_code.dart';

// void main() => runApp(MultiProvider(providers: providers, child: const App()));
void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SvranSizeFit.init();
    return OKToast(
      animationBuilder: const SvranMiui10AnimBuilder(),
      backgroundColor: Colors.black.withAlpha(0x99),
      textPadding: const EdgeInsets.all(15),
      position: ToastPosition.bottom,
      child: MaterialApp(
        title: '钛备份 - 备份管理',
        theme: ThemeData(
          appBarTheme: kDebugMode ? AppBarTheme(color: randomColor()) : null,
        ),
        supportedLocales: const [
          // 国际化支持
          Locale("zh"),
          Locale("en"),
          Locale("jp"),
        ],
        localizationsDelegates: const [
          // 国际化支持语言包
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: TbListPage(),
      ),
    );
  }
}
