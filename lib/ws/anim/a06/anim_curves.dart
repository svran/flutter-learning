import 'package:flutter/material.dart';

class CurvesDemoPage extends StatefulWidget {
  const CurvesDemoPage({Key? key}) : super(key: key);

  @override
  State<CurvesDemoPage> createState() => _CurvesDemoPageState();
}

class _CurvesDemoPageState extends State<CurvesDemoPage> {
  double _top = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("更多动画控制以及曲线"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _top = _top == 0 ? 300 : 0;
          });
        },
      ),
      body: AnimatedPadding(
        curve: Curves.bounceOut,
        padding: EdgeInsets.only(top: _top),
        duration: const Duration(seconds: 1),
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
        ),
      ),
    );
  }
}
