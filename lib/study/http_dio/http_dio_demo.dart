import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/ext/http/http_request.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/public_code.dart';

class HttpDioPage extends StatefulWidget {
  const HttpDioPage({Key? key}) : super(key: key);

  @override
  State<HttpDioPage> createState() => _HttpDioPageState();
}

class _PageWidget extends StatelessWidget {
  const _PageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withAlpha(0x30),
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: "请求网络",
            icon: const Icon(Icons.get_app),
            onPressed: () {
              svranToast("Dio get 请求网络");
              HttpRequest.request(
                "https://httpbin.org/get",
                params: {"name": "Svran"},
              ).then((value) {
                logger.d("Svran: Flutter -> $value");
              });
            },
          ),
        ],
      ),
    );
  }
}

class _HttpDioPageState extends State<HttpDioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("网络请求 Dio"),
        ),
        body: RawKeyboardListener(
          onKey: (event) {
            if (event.runtimeType == RawKeyUpEvent) {
              Navigator.pop(context);
            }
          },
          focusNode: FocusNode(),
          child: const _PageWidget(),
        ));
  }
}
