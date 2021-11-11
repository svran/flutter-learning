import 'dart:math';

import 'package:flutter/material.dart';

class FutureBuilderDemoPage extends StatefulWidget {
  const FutureBuilderDemoPage({Key? key}) : super(key: key);

  @override
  State<FutureBuilderDemoPage> createState() => _FutureBuilderDemoPageState();
}

class _FutureBuilderDemoPageState extends State<FutureBuilderDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FutureBuilder组件"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1), () {
            if (Random().nextBool()) {
              throw ("随机出错");
            }
            return 123;
          }),
          // initialData: 72, // 初始值
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // 有错?
              return Icon(Icons.error, size: 50);
            }
            if (snapshot.hasData) {
              // 有数据?
              return Text('${snapshot.data}');
            }
            // 没有错误且没有数据, 那么理论上是在等待 Future 中
            return CircularProgressIndicator();
            // switch (snapshot.connectionState) {
            //   case ConnectionState.waiting:
            //     return CircularProgressIndicator();
            //   case ConnectionState.done:
            //     if (snapshot.hasData)
            //       return Text('${snapshot.data}');
            //     else if (snapshot.hasError)
            //       return Text('error: ${snapshot.error}');
            //     else
            //       return Text('error! no Error');
            //   case ConnectionState.none:
            //     return Text('none');
            //   case ConnectionState.active:
            //     return Text('active');
            // }
          },
        ),
      ),
    );
  }
}
