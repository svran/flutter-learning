import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  _emptyWidget() {
    return const SizedBox(
      width: 1,
      height: 56,
    );
  }

  _randomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _reduceCounter() {
    setState(() {
      _counter--;
    });
  }

  var _borderColor = Color.fromARGB(255, Random.secure().nextInt(255),
      Random.secure().nextInt(255), Random.secure().nextInt(255));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首次学习"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: "请输入点什么",
                icon: Icon(Icons.people),
                hintText: "用户名",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: "请输入点什么",
                icon: Icon(Icons.lock),
                hintText: "密码",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {},
                child: const Text("获取", style: TextStyle(color: Colors.white)),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const Divider(height: 15, thickness: 1),
            SizedBox.fromSize(
              size: const Size(100, 100),
              child: Image.asset("assets/img/img_486.jpg"),
            ),
            const Divider(height: 15, thickness: 1),
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontFamily: "UDDigiKyokasho_NPB"),
            ),
            const Divider(height: 15, thickness: 1),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            onPressed: () {
              setState(() {
                _borderColor = _randomColor();
              });
            },
            child: const Text("色 →"),
            color: Colors.tealAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
              child: const Icon(Icons.message),
              tooltip: "显示Toast",
              onPressed: () {
                svranToast("普通的语言中应该不可能是完全凌乱的单字, 读起来也没这么糟糕这么慢吧 : $_counter");
              }),
          const SizedBox(height: 15),
          Visibility(
            replacement: _emptyWidget(),
            visible: _counter < 10,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: '增加',
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 15),
          Visibility(
            replacement: _emptyWidget(),
            visible: _counter > 0,
            child: FloatingActionButton(
              onPressed: _reduceCounter,
              tooltip: '减少',
              child: const Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
