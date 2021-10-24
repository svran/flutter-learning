import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/douban/pages/main/main.dart';
import 'package:svran_flutter_study/public_code.dart';
import 'package:svran_flutter_study/study/provider/initialize_providers.dart';

// void main() => runApp(const MyApp());
void main() => runApp(MultiProvider(providers: providers, child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      animationBuilder: const Miui10AnimBuilder(),
      backgroundColor: Colors.black.withAlpha(0x99),
      textPadding: const EdgeInsets.all(15),
      position: ToastPosition.bottom,
      // dismissOtherOnShow: true,
      child: MaterialApp(
        title: 'Svran Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: kDebugMode ? AppBarTheme(color: randomColor()) : null,
          fontFamily: "Roboto",
        ),
        home: const Scaffold(
          body: SvranMainPage(),
        ),
      ),
    );
  }
}
