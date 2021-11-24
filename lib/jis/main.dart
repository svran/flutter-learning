import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/toast/miui_10_anim_builder.dart';
import 'package:svran_flutter_study/jis/pages/basics_example.dart';
import 'package:svran_flutter_study/jis/pages/complex_example.dart';
import 'package:svran_flutter_study/jis/pages/events_example.dart';
import 'package:svran_flutter_study/jis/pages/multi_example.dart';
import 'package:svran_flutter_study/jis/pages/range_example.dart';
import 'package:svran_flutter_study/public_code.dart';

// void main() => runApp(MultiProvider(providers: providers, child: const App()));
void main() => runApp(const JiShiApp());

class JiShiApp extends StatelessWidget {
  const JiShiApp({Key? key}) : super(key: key);

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
        home: StartPage(),
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Basics'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableBasicsExample()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text('Range Selection'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableRangeExample()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text('Events'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableEventsExample()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text('Multiple Selection'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableMultiExample()),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              child: Text('Complex'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableComplexExample()),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
