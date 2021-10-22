import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/public_code.dart';


class AsynchronousPage extends StatefulWidget {
  const AsynchronousPage({Key? key}) : super(key: key);

  @override
  State<AsynchronousPage> createState() => _AsynchronousPageState();
}

/// 全局  cc 函数/方法
int cc(int count) {
  int t = 0;
  for (int i = 0; i <= 100; i++) {
    t += i;
  }
  return t;
}

class _AsynchronousPageState extends State<AsynchronousPage> {
  String _log = "这里算是日志内容吧";

  _async3() async {
    svranToast("开始");
    logger.d("Svran: Flutter -> 开始");
    var result = await compute(cc, 100); // 要使用其他线程执行的函数/方法, 必须全局.
    logger.d("Svran: Flutter -> 结束 : $result");
  }

  _async2() {
    svranToast("开始");
    logger.d("Svran: Flutter -> 开始");
    Future(() {
      sleep(const Duration(seconds: 2));
      return "第一次 延迟: 2";
    }).then((value) {
      logger.d("Svran: Flutter -> $value");
    }).then((value) {
      logger.d("Svran: Flutter -> $value");
      sleep(const Duration(seconds: 3));
      return "第二次 延迟: 3";
    }).catchError((onError) {
      logger.e("Svran: Flutter -> $onError");
    });

    Future.value("第一").then((value) {
      logger.d("Svran: Flutter -> $value");
    });

    Future.delayed(const Duration(seconds: 2), () {
      return "等一会";
    }).then((value) {
      logger.d("Svran: Flutter -> $value");
    });

    logger.d("Svran: Flutter -> 结束");
  }

  _async() {
    svranToast("开始");
    logger.d("Svran: Flutter -> 开始");
    _getNet().then((value) {
      _log = value;
      logger.d("Svran: Flutter -> $_log");
    }).then((value) {
      logger.i("Svran: Flutter -> 双then :$value");
    }).catchError((onError) {
      logger.e("Svran: Flutter -> 错误信息: $onError");
    }).whenComplete(() {
      logger.d("Svran: Flutter -> 代码执行完成!");
    });
    logger.d("Svran: Flutter -> 结束");
  }

  /// 将耗时操作,包裹到 Future
  /// 1. 只要有返回结果, 那么就执行 then
  /// 2. 如果有错误信息, 直接在Future 抛出一个异常.
  Future _getNet() {
    return Future(() {
      sleep(const Duration(seconds: 2));
      // throw Exception("这是错误信息");
      return "hello word get Net!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                _async3();
              },
              child: const Icon(Icons.looks_3),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                _async2();
              },
              child: const Icon(Icons.looks_two),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                _async();
              },
              child: const Icon(Icons.looks_one),
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text("异步"),
        ),
        body: Container(
          color: Colors.red.withAlpha(0x30),
          child: Text(_log),
        ));
  }
}
