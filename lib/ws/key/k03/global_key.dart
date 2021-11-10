import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class GlobalKeyDemoPage extends StatefulWidget {
  const GlobalKeyDemoPage({Key? key}) : super(key: key);

  @override
  State<GlobalKeyDemoPage> createState() => _GlobalKeyDemoPageState();
}

final _globalKey = GlobalKey();
final _globalKey2 = GlobalKey();

class _GlobalKeyDemoPageState extends State<GlobalKeyDemoPage> {
  @override
  Widget build(BuildContext context) {
    var ori = MediaQuery.of(context).orientation;
    logger.d("Svran: Flutter -> ori: $ori");
    return Scaffold(
      appBar: AppBar(
        title: const Text("全局键 GlobalKey 的两种用法"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var s = _globalKey.currentContext?.findRenderObject() as RenderBox;
          logger.d("Svran: Flutter -> ${s.size}");
        },
      ),
      body: Center(
          child: Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: ori == Orientation.portrait ? Axis.vertical : Axis.horizontal,
        children: <Widget>[
          Text('1. 组件状态的保存, 2. 相当于组件ID.'),
          Counter(key: _globalKey2),
          Center(child: Counter(key: _globalKey)), // _globalKey 只有一对一, 不能把一个 key 给多个控件使用.
        ],
      )),
      // body: Center(
      //   child: ori == Orientation.portrait
      //       ? Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             Counter(key: _globalKey2),
      //             Center(child: Counter(key: _globalKey)), // _globalKey 只有一对一, 不能把一个 key 给多个控件使用.
      //           ],
      //         )
      //       : Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             Counter(key: _globalKey2),
      //             Center(child: Counter(key: _globalKey)), // _globalKey 只有一对一, 不能把一个 key 给多个控件使用.
      //           ],
      //         ),
      // ),
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
