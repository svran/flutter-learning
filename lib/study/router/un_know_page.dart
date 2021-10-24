import 'package:flutter/material.dart';

class RouterUnknownPage extends StatefulWidget {
  static const String routeName = "/unknown";

  const RouterUnknownPage({Key? key}) : super(key: key);

  @override
  State<RouterUnknownPage> createState() => _RouterUnknownPageState();
}

class _RouterUnknownPageState extends State<RouterUnknownPage> {
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
            title: const Text("路由跳转错误页"),
            // leading: Icon(Icons.backspace),
          ),
          body: Container(
            color: Colors.red.withAlpha(0x30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('路由错误页'),
                  TextButton(
                    onPressed: () => _backTo(),
                    child: const Text('返回 参数'),
                  ),
                  // Text(_message),
                ],
              ),
            ),
          )),
    );
  }

  _backTo() {
    Navigator.pop(context);
  }
}
