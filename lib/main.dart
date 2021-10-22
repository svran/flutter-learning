import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/logger/svran_pretty_printer.dart';

import 'beans/svran_list_bean.dart';
import 'first/my_home_page.dart';
import 'public_code.dart';
import 'study/async/async_demo.dart';
import 'study/http_dio/http_dio_demo.dart';
import 'study/layout/layout.dart';
import 'study/scroll_widget/custom_sliver_view_demo.dart';
import 'study/scroll_widget/grid_view_demo.dart';
import 'study/scroll_widget/list_view_demo.dart';
import 'study/scroll_widget/scroll_view_listen_demo.dart';

void main() => runApp(const MyApp());
final List<SvranListBean> data = [
  SvranListBean("网络请求 Dio", const HttpDioPage()),
  SvranListBean("异步", const AsynchronousPage()),
  SvranListBean("滚动监听", const ScrollViewListenPage()),
  SvranListBean("自定义滚动控件CustomSliverView", const CustomSliverViewPage()),
  SvranListBean("滚动控件GridView", const GridViewPage()),
  SvranListBean("滚动控件ListView", const ListViewPage()),
  SvranListBean("布局", const MyLayoutHomePage()),
  SvranListBean("首次学习", const MyHomePage()),
];

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
          fontFamily: "Roboto",
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("这是我学习Flutter的记录"),
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
      child: ListView.separated(itemBuilder: _itemBuilder, separatorBuilder: _separatorBuilder, itemCount: data.length),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return ListTile(
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
