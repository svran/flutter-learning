import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';
import 'package:svran_flutter_study/ws/anim/a04/animated_counter.dart';

class AnimatedNumberDemoPage1 extends StatefulWidget {
  const AnimatedNumberDemoPage1({Key? key}) : super(key: key);

  @override
  State<AnimatedNumberDemoPage1> createState() => _AnimatedNumberDemoPageState1();
}

class _AnimatedNumberDemoPageState1 extends State<AnimatedNumberDemoPage1> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("计数器2"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _counter += 1;
          });
        },
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 120,
          child: AnimatedCounter(
            value: _counter,
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }
}
