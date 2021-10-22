import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class InheritedWidgetPage extends StatefulWidget {
  const InheritedWidgetPage({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetPage> createState() => _InheritedWidgetPageState();
}

class _InheritedWidgetPageState extends State<InheritedWidgetPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("状态管理 InheritedWidget"),
      ),
      body: SvranCounterWidget(
        counter: _counter,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SvranShowData01(),
              SvranShowData02(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
      ),
    );
  }
}

class SvranCounterWidget extends InheritedWidget {
  // 共享数据
  final int counter;

  // 构造方法
  const SvranCounterWidget({
    Key? key,
    required Widget child,
    this.counter = 0,
  }) : super(key: key, child: child);

  static SvranCounterWidget? of(BuildContext context) {
    // 沿着Element 查找最近的SvranCounterWidgetElement 从 Element 取出Widget 对象
    return context.dependOnInheritedWidgetOfExactType();
  }

  // 决定 要不要 回调 didChangeDependencies 方法
  @override
  bool updateShouldNotify(SvranCounterWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}

class SvranShowData01 extends StatefulWidget {
  const SvranShowData01({Key? key}) : super(key: key);

  @override
  State<SvranShowData01> createState() => _SvranShowData01State();
}

class _SvranShowData01State extends State<SvranShowData01> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d("Svran: Flutter -> didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    int counter = SvranCounterWidget.of(context)?.counter ?? 0;
    return Card(
      color: Colors.red,
      child: Text(
        '当前计数: $counter',
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}

class SvranShowData02 extends StatelessWidget {
  const SvranShowData02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = SvranCounterWidget.of(context)?.counter ?? 0;
    return Container(
      color: Colors.blue,
      child: Text(
        '当前计数: $counter',
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
