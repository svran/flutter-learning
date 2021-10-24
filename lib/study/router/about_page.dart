import 'package:flutter/material.dart';

class RouterAboutPage extends StatefulWidget {
  static const String routeName = "/about";

  const RouterAboutPage({Key? key}) : super(key: key);

  @override
  State<RouterAboutPage> createState() => _RouterAboutPageState();
}

class _RouterAboutPageState extends State<RouterAboutPage> {
  String _message = "";

  @override
  Widget build(BuildContext context) {
    _message = ModalRoute.of(context)?.settings.arguments as String;
    return WillPopScope(
      onWillPop: () {
        // return Future.value(true); // Flutter 帮我们返回.
        // return Future.value(false); // 自己写返回代码.
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("关于页"),
            // leading: Icon(Icons.backspace),
          ),
          body: Container(
            color: Colors.red.withAlpha(0x30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('关于页'),
                  TextButton(
                    onPressed: () => _backTo(),
                    child: const Text('返回 参数'),
                  ),
                  Text(_message),
                ],
              ),
            ),
          )),
    );
  }

  _backTo() {
    Navigator.pop(context, "返回的Message 传递过来的是:$_message");
  }
}
