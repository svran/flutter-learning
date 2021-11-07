import 'package:flutter/material.dart';

class AnimatedUnlimitedDemoPage extends StatefulWidget {
  const AnimatedUnlimitedDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimatedUnlimitedDemoPage> createState() => _AnimatedUnlimitedDemoPageState();
}

class _AnimatedUnlimitedDemoPageState extends State<AnimatedUnlimitedDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("无尽旋转的显式动画"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat();
          }
        },
      ),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Icon(
            Icons.refresh,
            size: 55,
          ),
        ),
      ),
    );
  }
}
