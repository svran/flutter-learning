import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/douban/pages/main/main.dart';
import 'package:svran_flutter_study/douban/widget/dashed_line.dart';
import 'package:svran_flutter_study/douban/widget/star_rating.dart';
import 'package:svran_flutter_study/public_code.dart';

void main() => runApp(const MyApp());

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
