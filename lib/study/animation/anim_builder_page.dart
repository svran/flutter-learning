import 'package:flutter/material.dart';

class AnimBuilderDemoPage extends StatefulWidget {
  const AnimBuilderDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimBuilderDemoPage> createState() => _AnimBuilderDemoPageState();
}

class _AnimBuilderDemoPageState extends State<AnimBuilderDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late Animation _sizedAnim;

  @override
  void initState() {
    super.initState();
    // 创建 AnimationController
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _sizedAnim = Tween(begin: 50.0, end: 150.0).animate(_animation);

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
            return Icon(
              Icons.favorite,
              color: Colors.red,
              size: _sizedAnim.value,
            );
          },
          animation: _controller,
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: _animation.value,
          ),
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
