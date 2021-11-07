import 'package:flutter/material.dart';

class AminControllerTweenDemoPage extends StatefulWidget {
  const AminControllerTweenDemoPage({Key? key}) : super(key: key);

  @override
  State<AminControllerTweenDemoPage> createState() => _AminControllerTweenDemoPageState();
}

class _AminControllerTweenDemoPageState extends State<AminControllerTweenDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.addListener(() {});
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
        title: const Text("控制器串联补间动画和曲线"),
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
        child: SlideTransition(
          // scale: _controller.drive(Tween(begin: 0.5, end: 2.0)),
          // position: _controller.drive(Tween(begin: Offset(0, 0), end: Offset(1, 1))), // 原始控件0倍到1倍
          position: Tween(begin: Offset(0, -0.5), end: Offset(0, 0.5))
              // .chain(CurveTween(curve: Interval(0.5, 1.0)))
              .chain(CurveTween(curve: Curves.elasticInOut))
              .animate(_controller), // 原始控件0倍到1倍
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
