import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../public_code.dart';

class SvranBoomMainPage extends StatefulWidget {
  const SvranBoomMainPage({Key? key}) : super(key: key);

  @override
  State<SvranBoomMainPage> createState() => _SvranBoomMainPageState();
}

class _SvranBoomMainPageState extends State<SvranBoomMainPage> with SingleTickerProviderStateMixin {
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

  Offset pressPoint = Offset.zero;
  int time = 0;
  DateTime startTime = DateTime.now();
  Duration duration = const Duration(seconds: 1);

  List<_Circle> circles = List.generate(20, (index) => _Circle());

  @override
  Widget build(BuildContext context) {
    _Circle c = _Circle();
    return Scaffold(
      appBar: AppBar(
        title: const Text("效果"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _controller.forward(from: 0.0);
        },
      ),
      body: GestureDetector(
        onTapDown: (details) {
          pressPoint = details.localPosition;
          logger.d("Svran: Flutter -> 点击 按下 -> $pressPoint");
        },
        onTapUp: (details) {
          pressPoint = details.localPosition;
          logger.d("Svran: Flutter -> 点击抬起 -> $pressPoint");
        },
        onLongPressStart: (details) => startTime = DateTime.now(),
        onLongPressUp: () {
          var durationTime = startTime.difference(DateTime.now()).inMilliseconds;
          logger.d("Svran: Flutter -> 长按抬起 -> $pressPoint - $durationTime");
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue[300],
          child: AnimatedBuilder(
            builder: (BuildContext context, child) {
              logger.d("Svran: Flutter -> ${_controller.value}");
              return Stack(
                children: [
                  Container(
                    width: _controller.value * c.maxR,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              );
            },
            animation: _controller,
          ),
        ),
      ),
    );
  }
}

class PointWidget extends StatelessWidget {
  final Duration duration;
  final _Circle circle;

  const PointWidget({Key? key, required this.duration, required this.circle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: circle.minR,
      height: circle.minR,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      duration: duration,
    );
  }
}

class _PointPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Circle {
  double maxR = Random().nextDouble() * 35 + 150;
  double minR = Random().nextDouble() * 15 + 10;
  double d = Random().nextDouble() * 100;
  double radian = Random().nextDouble() * 2 * pi;
  Color color = randomColor();

  boom() {
    maxR -= 1;
    if (maxR <= 0) {
      maxR = 0;
    }
  }
}
