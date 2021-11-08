import 'dart:math';

import 'package:flutter/material.dart';

class SvranLocalKeyDemoPage extends StatefulWidget {
  const SvranLocalKeyDemoPage({Key? key}) : super(key: key);

  @override
  State<SvranLocalKeyDemoPage> createState() => _SvranLocalKeyDemoPageState();
}

class _SvranLocalKeyDemoPageState extends State<SvranLocalKeyDemoPage> {
  List<Widget> containers = [
    // Container(width: 300, height: 100, color: Colors.blue),
    // Container(width: 300, height: 100, color: Colors.orange),
    Box(key: UniqueKey()),
    Box(key: UniqueKey()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("局部键 LocalKey 三种类型"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => setState(() {
          final last = containers.removeLast();
          containers.insert(0, last);
        }),
      ),
      body: Center(
        // 无状态控件,基本用不到key, 有状态的控件,才可能需要用到key
        // ValueKey() 判断相等用的是 == 操作符, 判断值相等.
        // ObjectKey() 判断相等用的是 identical 关键字判断对象相同.
        // UniqueKey() 独一无二的Key, 只能与自己相等.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: containers,
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  const Box({Key? key}) : super(key: key);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  final color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      color: color,
    );
  }
}
