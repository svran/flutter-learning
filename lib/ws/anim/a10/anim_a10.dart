import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ws/anim/a08/anim_controller.dart';

class SvranAnimA10DemoPage extends StatefulWidget {
  const SvranAnimA10DemoPage({Key? key}) : super(key: key);

  @override
  State<SvranAnimA10DemoPage> createState() => _SvranAnimA10DemoPageState();
}

class _SvranAnimA10DemoPageState extends State<SvranAnimA10DemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
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
        title: const Text("交错动画,管理区间,曲线"),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideBox(controller: _controller, color: Colors.blue[100], interval: Interval(0.0, 0.2)),
            SlideBox(controller: _controller, color: Colors.blue[300], interval: Interval(0.2, 0.4)),
            SlideBox(controller: _controller, color: Colors.blue[500], interval: Interval(0.4, 0.6)),
            SlideBox(controller: _controller, color: Colors.blue[700], interval: Interval(0.6, 0.8)),
            SlideBox(controller: _controller, color: Colors.blue[900], interval: Interval(0.8, 1.0)),
          ],
        ),
      ),
    );
  }
}

class SlideBox extends StatelessWidget {
  const SlideBox({
    Key? key,
    required AnimationController controller,
    required this.color,
    required this.interval,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final Color? color;
  final Interval interval;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: Tween(begin: const Offset(-0.3, 0.0), end: const Offset(0.3, 0.0))
            .chain(CurveTween(curve: interval))
            .chain(CurveTween(curve: Curves.bounceOut))
            .animate(_controller),
        child: Container(width: 300, height: 100, color: color));
  }
}
