import 'dart:async';

import 'package:flutter/material.dart';

import '../../../public_code.dart';

class StreamAndStreamBuilderDemoPage extends StatefulWidget {
  const StreamAndStreamBuilderDemoPage({Key? key}) : super(key: key);

  @override
  State<StreamAndStreamBuilderDemoPage> createState() => _StreamAndStreamBuilderDemoPageState();
}

class _StreamAndStreamBuilderDemoPageState extends State<StreamAndStreamBuilderDemoPage> {
  // final future = Future.delayed(Duration(seconds: 1), () {});
  // final stream = Stream.periodic(Duration(seconds: 1), (s) => 42);

  // broadcast 广播数据流,如果没监听,那么数据不会缓存的. 非广播数据流,没监听的时候,会缓存, 但是只能有一个监听者.
  final controller = StreamController();

  // final controller = StreamController.broadcast();

  @override
  void initState() {
    controller.sink.add(72);
    // controller.stream.listen((event) {
    //   logger.d("Svran: Flutter broadcast -> $event");
    // });
    super.initState();
  }

  Stream<DateTime> getTime() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now();
    }
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream与StreamBuilder组件"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                controller.sink.add(10);
              },
              icon: const Icon(Icons.arrow_right),
              label: const Text('10'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.sink.add(3);
              },
              icon: const Icon(Icons.arrow_right),
              label: const Text('3'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.sink.add('Hi');
              },
              icon: const Icon(Icons.arrow_right),
              label: const Text('Hi'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.sink.addError("error");
              },
              icon: const Icon(Icons.error),
              label: const Text('error'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.sink.close();
              },
              icon: const Icon(Icons.close),
              label: const Text('close'),
            ),
            StreamBuilder(
              // 可以对数据流进行 变换, 过滤, 去重, 等操作.
              stream: controller.stream.map((event) => event * 2).where((event) => event is int).distinct(),
              builder: (context, snapshot) {
                logger.d("Svran: Flutter -> build");
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('None: 没有数据流');
                  case ConnectionState.waiting:
                    return Text('Waiting: 等待数据流');
                  case ConnectionState.active:
                    if (snapshot.hasError) {
                      return Text('Active: 错误: ${snapshot.error}');
                    }
                    if (snapshot.hasData) {
                      return Text('Active: 数据: ${snapshot.data}');
                    }
                    return Text('未知!?');
                  case ConnectionState.done:
                    return Text('Done: 数据流已经关闭');
                }
                return Container(color: Colors.blue[100]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
