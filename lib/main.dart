import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/ui/shared/svran_pixel.dart';
import 'package:svran_flutter_study/study/provider/initialize_providers.dart';
import 'package:svran_flutter_study/study/router/svran_router.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

import 'generated/l10n.dart';
import 'public_code.dart';
import 'study/initalize_pages_data.dart';

// void main() => runApp(const MyApp());
void main() => runApp(MultiProvider(providers: providers, child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SvranSizeFit.init();
    return SvranPixel(
      builder: (context) {
        return OKToast(
          animationBuilder: const Miui10AnimBuilder(),
          backgroundColor: Colors.black.withAlpha(0x99),
          textPadding: const EdgeInsets.all(15),
          position: ToastPosition.bottom,
          // dismissOtherOnShow: true,
          child: MaterialApp(
            onUnknownRoute: SvranRouter.unknownRoute,
            onGenerateRoute: SvranRouter.generateRoute,
            routes: SvranRouter.routes,
            title: 'Svran Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: kDebugMode ? AppBarTheme(color: randomColor()) : null,
              fontFamily: "Roboto",
            ),
            home: Scaffold(
              appBar: AppBar(
                title: const Text("这是我学习Flutter的记录"),
              ),
              body: const SvranListWidget(),
            ),
            supportedLocales: S.delegate.supportedLocales,
            // const [
            //   // 国际化支持
            //   Locale("zh"),
            //   Locale("en"),
            //   Locale("jp"),
            // ],
            localizationsDelegates: const [
              // 国际化支持语言包
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              // SvranLocalizationsDelegate.delegate,
              S.delegate,
            ],
          ),
        );
      },
    );
  }
}

class SvranListWidget extends StatefulWidget {
  const SvranListWidget({Key? key}) : super(key: key);

  @override
  State<SvranListWidget> createState() => _SvranListWidgetState();
}

class _SvranListWidgetState extends State<SvranListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(itemBuilder: _itemBuilder, separatorBuilder: _separatorBuilder, itemCount: data.length),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      key: ValueKey(data[index].title),
      title: Text(data[index].title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => data[index].widget));
      },
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: 1,
    );
  }
}
