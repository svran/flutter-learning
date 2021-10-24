import 'package:flutter/material.dart';

class RouterDetailPage extends StatefulWidget {
  static const String routeName = "/detail";
  final String _message;

  const RouterDetailPage({
    Key? key,
    String? message,
  })  : _message = message ?? "",
        super(key: key);

  @override
  State<RouterDetailPage> createState() => _RouterDetailPageState();
}

class _RouterDetailPageState extends State<RouterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // return Future.value(true); // Flutter 帮我们返回.
        // return Future.value(false); // 自己写返回代码.
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("详情页"),
            // leading: Icon(Icons.backspace),
          ),
          body: Container(
            color: Colors.red.withAlpha(0x30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('详情页'),
                  TextButton(
                    onPressed: () => _backTo(),
                    child: const Text('返回 参数'),
                  ),
                  Text(widget._message),
                ],
              ),
            ),
          )),
    );
  }

  _backTo() {
    Navigator.pop(context, "返回的Message 传递过来的是:${widget._message}");
  }
}
