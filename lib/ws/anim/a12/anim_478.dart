import 'package:flutter/material.dart';

class Anim478DemoPage extends StatefulWidget {
  const Anim478DemoPage({Key? key}) : super(key: key);

  @override
  State<Anim478DemoPage> createState() => _Anim478DemoPageState();
}

class _Anim478DemoPageState extends State<Anim478DemoPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerOp;

  @override
  void initState() {
    // _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _controller = AnimationController(vsync: this);
    _controllerOp = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerOp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Animation anim1 =
    //     Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: const Interval(0.0, 0.2))).animate(_controller);
    // Animation anim3 =
    //     Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: const Interval(0.4, 0.95))).animate(_controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text("478呼吸法动画"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          _controller.duration = const Duration(seconds: 4);
          _controller.forward();
          await Future.delayed(const Duration(seconds: 4));

          _controllerOp.duration = const Duration(milliseconds: 1750);
          _controllerOp.repeat(reverse: true);
          await Future.delayed(const Duration(seconds: 7));

          _controller.duration = const Duration(seconds: 8);
          _controller.reverse();
          // if (_controller.isAnimating) {
          //   _controller.stop();
          // } else {
          //   _controller.repeat(reverse: true);
          // }
        },
      ),
      body: Center(
        child: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.5).animate(_controllerOp),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue[600]!,
                      Colors.blue[100]!,
                    ],
                    stops: [_controller.value, _controller.value + 0.1],
                    // stops: _controller.value <= 0.2 ? [anim1.value, anim1.value + 0.1] : [anim3.value, anim3.value + 0.1],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
