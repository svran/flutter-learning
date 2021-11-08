import 'package:flutter/material.dart';

class NoKeyDemoPage extends StatefulWidget {
  const NoKeyDemoPage({Key? key}) : super(key: key);

  @override
  State<NoKeyDemoPage> createState() => _NoKeyDemoPageState();
}

class _NoKeyDemoPageState extends State<NoKeyDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("没Key会发生什么现象"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // 如果在这里变换了,虽然控件变换了, 数值却没有按照预期变换, 如果加入Key参数之后,则就按照预期交换
            Box(/*key: ValueKey(1),*/ color: Colors.blueAccent),
            Box(/*key: ValueKey(2),*/ color: Colors.orange),
            Box(/*key: ValueKey(3),*/ color: Colors.green),
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  final Color color;

  const Box({Key? key, required this.color}) : super(key: key);

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      color: widget.color,
      child: Center(
        child: ElevatedButton(
          onPressed: () => setState(() => _count++),
          child: Text(
            '$_count',
            style: TextStyle(fontSize: 52),
          ),
        ),
      ),
    );
  }
}
