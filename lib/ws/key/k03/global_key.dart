import 'package:flutter/material.dart';

class GlobalKeyDemoPage extends StatefulWidget {
  const GlobalKeyDemoPage({Key? key}) : super(key: key);

  @override
  State<GlobalKeyDemoPage> createState() => _GlobalKeyDemoPageState();
}

final _globalKey = GlobalKey();

class _GlobalKeyDemoPageState extends State<GlobalKeyDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("全局键 GlobalKey 的两种用法"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Counter(),
            Center(child: Counter(key: _globalKey)),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() {
        _count++;
      }),
      child: Text('$_count', style: const TextStyle(fontSize: 50)),
    );
  }
}
