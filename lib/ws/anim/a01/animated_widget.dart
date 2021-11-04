import 'package:flutter/material.dart';

class AnimatedWidgetDemoPage extends StatefulWidget {
  const AnimatedWidgetDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimatedWidgetDemoPage> createState() => _AnimatedWidgetDemoPageState();
}

class _AnimatedWidgetDemoPageState extends State<AnimatedWidgetDemoPage> {
  double _h = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedWidgetDemoPage"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _h += 100;
            if (_h > 500) _h = 100;
          });
        },
      ),
      body: Center(
        child: AnimatedContainer(
          color: Colors.blue,
          height: _h,
          width: _h / 2,
          duration: const Duration(seconds: 1),
          child: const Center(
            child: Text(
              '系统自带动画效果的小部件 命名都以 Animated开始',
              style: TextStyle(fontSize: 11),
            ),
          ),
        ),
      ),
    );
  }
}
