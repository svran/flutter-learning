import 'dart:math';

import 'package:flutter/material.dart';

class SvranAnimDemoPage extends StatefulWidget {
  const SvranAnimDemoPage({Key? key}) : super(key: key);

  @override
  State<SvranAnimDemoPage> createState() => _SvranAnimDemoPageState();
}

class _SvranAnimDemoPageState extends State<SvranAnimDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late Animation _sizedAnim;
  late Animation _colorAnim;
  late Animation _opacityAnim;
  late Animation _radiansAnim;

  @override
  void initState() {
    super.initState();
    // 创建 AnimationController
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _sizedAnim = Tween(begin: 10.0, end: 200.0).animate(_controller);
    _colorAnim = ColorTween(begin: Colors.orange, end: Colors.purple).animate(_controller);
    _opacityAnim = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _radiansAnim = Tween(begin: 0.0, end: 2 * pi).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("动画"),
      ),
      body: Center(
        child: AnimatedBuilder(
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: _opacityAnim.value,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(_radiansAnim.value),
                child: Container(
                  width: _sizedAnim.value,
                  height: _sizedAnim.value,
                  color: _colorAnim.value,
                  // transform: Matrix4.rotationZ(pi / 4),
                ),
              ),
            );
          },
          animation: _animation,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            if (_controller.status == AnimationStatus.forward) {
              _controller.forward();
            } else if (_controller.status == AnimationStatus.reverse) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // 动画用完 销毁
  }
}
