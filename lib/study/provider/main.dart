import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/main.dart';
import 'package:svran_flutter_study/public_code.dart';
import 'package:svran_flutter_study/study/provider/view_model/counter_view_model.dart';

// provider :
// 创建自己需要共享的数据.
// 在应用顶层 ChangeNotifierProvider .
// 在其他位置使用共享数据.

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => SvranCounterViewModel(),
        child: const MyApp(),
      ),
    );

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
          primarySwatch: Colors.blue,
          appBarTheme: kDebugMode ? AppBarTheme(color: randomColor()) : null,
          // fontFamily: "Roboto",
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("这是我学习Flutter的记录(Provider)"),
          ),
          body: const SvranListWidget(),
        ),
      ),
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
      child: ListView.separated(
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: data.length),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
      title: Text(data[index].title),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => data[index].widget));
      },
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: 1,
    );
  }
}
