import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class ScrollViewListenPage extends StatefulWidget {
  const ScrollViewListenPage({Key? key}) : super(key: key);

  @override
  State<ScrollViewListenPage> createState() => _ScrollViewListenPageState();
}

// 滚动两种监听方式.
// controller (可设置默认值, 可监听滚动位置)
// NotificationListener

class _ScrollViewListenPageState extends State<ScrollViewListenPage> {
  final ScrollController _controller = ScrollController(initialScrollOffset: 100);
  bool _isShowFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      // ext.logger.d("Svran: Flutter -> 监听到滚动:${_controller.offset}");
      setState(() {
        _isShowFloatingButton = _controller.offset >= 300;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _isShowFloatingButton
            ? FloatingActionButton(
                onPressed: () {
                  _controller.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeIn);
                },
                child: const Icon(Icons.arrow_upward),
              )
            : null,
        appBar: AppBar(
          title: const Text("滚动监听"),
        ),
        body: _BodyWidget(controller: _controller));
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
    required ScrollController controller,
  })  : _controller = controller,
        super(key: key);

  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withAlpha(0x30),
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            logger.d("Svran: Flutter -> 开始滚动");
          } else if (notification is ScrollUpdateNotification) {
            logger.d("Svran: Flutter ->"
                "正在滚动... "
                "总滚动距离:${notification.metrics.maxScrollExtent},"
                "当前位置:${notification.metrics.pixels}");
          } else if (notification is ScrollEndNotification) {
            logger.d("Svran: Flutter -> 结束滚动");
          }
          return true;
        },
        child: ListView.builder(
            itemCount: 100,
            controller: _controller,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.people),
                trailing: const Icon(Icons.delete),
                title: Text('联系人 : ${index + 1}', style: const TextStyle(fontSize: 30)),
                subtitle: Text('电话号码: 11111155555${index + 1}'),
              );
            }),
      ),
    );
  }
}
