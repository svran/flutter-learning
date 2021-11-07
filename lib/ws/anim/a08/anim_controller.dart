import 'package:flutter/material.dart';

import '../../../public_code.dart';

class AnimControllerDemoPage extends StatefulWidget {
  const AnimControllerDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimControllerDemoPage> createState() => _AnimControllerDemoPageState();
}

class _AnimControllerDemoPageState extends State<AnimControllerDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      // lowerBound: 3.0,
      // upperBound: 5.0,
    );
    _controller.addListener(() {
      logger.d("Svran: Flutter -> ${_controller.value}");
    });
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
        title: const Text("动画控制器"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat(reverse: true);
          }
        },
      ),
      body: Center(
        child: ScaleTransition(
          // child: FadeTransition(
          //   opacity: _controller,
          // child: RotationTransition(
          //   turns: _controller,
          scale: _controller,
          child: Icon(
            Icons.refresh,
            size: 55,
          ),
        ),
      ),
    );
  }
}
