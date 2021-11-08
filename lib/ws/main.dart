import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/toast/miui_10_anim_builder.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

import '../public_code.dart';
import 'initalize_ws_pages_data.dart';

// void main() => runApp(MultiProvider(providers: providers, child: const App()));
void main() => runApp(const WsApp());

class WsApp extends StatelessWidget {
  const WsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SvranSizeFit.init();
    return OKToast(
      animationBuilder: const SvranMiui10AnimBuilder(),
      backgroundColor: Colors.black.withAlpha(0x99),
      textPadding: EdgeInsets.all(15.px),
      position: ToastPosition.bottom,
      // dismissOtherOnShow: true,
      child: MaterialApp(
        // onUnknownRoute: AppRoutes.routes,
        title: '新的学习',
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
          appBar: AppBar(
            title: const Text('新的学习'),
            actions: [
              IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    svranToast("不可再返回");
                  }
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          body: const SvranWsListWidget(),
        ),
      ),
    );
  }
}

class SvranWsListWidget extends StatefulWidget {
  const SvranWsListWidget({Key? key}) : super(key: key);

  @override
  State<SvranWsListWidget> createState() => _SvranWsListWidgetState();
}

class _SvranWsListWidgetState extends State<SvranWsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.px),
      child: ListView.separated(
        itemBuilder: _itemBuilder,
        separatorBuilder: _separatorBuilder,
        itemCount: wsData.length,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      key: ValueKey(wsData[index].title),
      title: Text(wsData[index].title),
      leading: SizedBox(
        width: 30.px,
        height: 30.px,
        child: CircleAvatar(
          backgroundColor: colorByIndex(index),
          child: Text('${index + 1}'),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => wsData[index].widget));
      },
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: 1,
    );
  }
}
