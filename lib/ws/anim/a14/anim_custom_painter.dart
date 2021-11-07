import 'dart:math';

import 'package:flutter/material.dart';

class AminCustomPainterDemoPage extends StatefulWidget {
  const AminCustomPainterDemoPage({Key? key}) : super(key: key);

  @override
  State<AminCustomPainterDemoPage> createState() => _AminCustomPainterDemoPageState();
}

class _AminCustomPainterDemoPageState extends State<AminCustomPainterDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<Snowflake> list = List.generate(100, (index) => Snowflake());

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
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
        title: const Text("直接操作底层的 CustomPainter"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          // width: double.infinity,
          // height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.lightBlue,
                Colors.white,
              ],
              stops: [0.0, 0.7, 0.95],
            ),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              for (var element in list) {
                element.fall();
              }
              return CustomPaint(
                painter: MyPainter(list),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Snowflake> snowflakes;

  MyPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    // logger.d("Svran: Flutter -> ${size.width} , ${size.height}");
    final whitePaint = Paint()..color = Colors.white;
    // Offset(size.width / 2, size.height / 2) 等于 size.center(Offset.zero)
    canvas.drawCircle(size.center(const Offset(0, 110)), 60.0, whitePaint);
    canvas.drawOval(Rect.fromCenter(center: size.center(const Offset(0, 280)), width: 200, height: 250), whitePaint);
    for (var snowflake in snowflakes) {
      snowflake.w = size.width;
      snowflake.h = size.height;
      canvas.drawCircle(Offset(snowflake.x, snowflake.y), snowflake.radius, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Snowflake {
  double w = 600, h = 800;
  double x = Random().nextDouble() * 600;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 2 + 4;
  double velocity = Random().nextDouble() * 4 + 2;

  fall() {
    y += velocity;
    if (y >= h) {
      x = Random().nextDouble() * w;
      y = 0.0;
      radius = Random().nextDouble() * 2 + 4;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
