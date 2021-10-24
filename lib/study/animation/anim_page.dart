import 'package:flutter/material.dart';

class AnimDemoPage extends StatefulWidget {
  const AnimDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimDemoPage> createState() => _AnimDemoPageState();
}

// Animation 抽象类,
// - 监听动画值得改变
// - 监听动画状态改变

// AnimationController 继承自 Animation
// vsync: 同步信号 (this) -> with SingleTickerProviderStateMixin

// CurvedAnimation 设置动画执行的速率

// Tween 动画执行 value 范围

// final controller = AnimationController(vsync: this);
// // https://api.flutter-io.cn/flutter/animation/Curves-class.html
// final animation = CurvedAnimation(parent: controller, curve: Curves.ease);
// Tween(begin: 0, end: 100).animate(animation);

class _AnimDemoPageState extends State<AnimDemoPage> with SingleTickerProviderStateMixin {
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
    // _controller.addListener(() {
    //   setState(() {});
    // });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // 动画用完 销毁
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        appBar: AppBar(
          title: const Text("动画"),
        ),
        body: Center(
          child: SvranAnimatedIcon(
            sizedAnim: _sizedAnim,
          ),
        ));
  }
}

class SvranAnimatedIcon extends AnimatedWidget {

  const SvranAnimatedIcon({Key? key, required Animation sizedAnim}) : super(key: key, listenable: sizedAnim);

  @override
  Widget build(BuildContext context) {
    Animation anim = listenable as Animation;
    return Icon(
      Icons.favorite,
      color: Colors.red,
      size: anim.value,
    );
  }
}

// XXX ================================================================================================================

class _AnimDemoPageStateBasic extends State<AnimDemoPage> with SingleTickerProviderStateMixin {
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
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // 动画用完 销毁
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        appBar: AppBar(
          title: const Text("动画"),
        ),
        body: Center(
          child: Icon(
            Icons.favorite,
            color: Colors.red,
            size: _sizedAnim.value,
          ),
        ));
  }
}
