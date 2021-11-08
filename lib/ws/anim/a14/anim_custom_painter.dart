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
          decoration: const BoxDecoration(
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

  final whitePaint = Paint()..color = Colors.white;
  final blackPointPaint = Paint()..color = Colors.black;
  final blackNosePaint = Paint()..color = Colors.orangeAccent;
  final blackLinePaint = Paint()
    ..strokeWidth = 1
    ..color = Colors.black
    ..style = PaintingStyle.stroke;
  final blackLineHandPaint = Paint()
    ..strokeWidth = 4
    ..color = Colors.black
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    // logger.d("Svran: Flutter -> ${size.width} , ${size.height}");
    // Offset(size.width / 2, size.height / 2) 等于 size.center(Offset.zero)

    // 头
    canvas.drawCircle(size.bottomCenter(const Offset(0, -250)), 60.0, whitePaint);

    // 身子
    canvas.drawOval(
        Rect.fromCenter(center: size.bottomCenter(const Offset(0, -100)), width: 200, height: 250), whitePaint);

    // 眼珠子两颗
    canvas.drawCircle(size.bottomCenter(const Offset(-20, -270)), 5, blackPointPaint);
    canvas.drawCircle(size.bottomCenter(const Offset(20, -270)), 5, blackPointPaint);

    // 微笑嘴吧 贝赛尔曲线起始点,控制点,结束点
    var startPoint = size.bottomCenter(const Offset(-15, -240));
    var controlPoint1 = size.bottomCenter(const Offset(0, -225));
    var endPoint = size.bottomCenter(const Offset(15, -240));

    // 绘制微笑嘴巴
    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(controlPoint1.dx, controlPoint1.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, blackLinePaint);

    // 绘制左右手
    canvas.drawLine(
        size.bottomCenter(const Offset(-50, -180)), size.bottomCenter(const Offset(-130, -230)), blackLineHandPaint);
    canvas.drawLine(
        size.bottomCenter(const Offset(50, -180)), size.bottomCenter(const Offset(130, -230)), blackLineHandPaint);

    // 扣子三颗
    canvas.drawCircle(size.bottomCenter(const Offset(0, -110)), 5, blackLinePaint);
    canvas.drawCircle(size.bottomCenter(const Offset(0, -140)), 5, blackLinePaint);
    canvas.drawCircle(size.bottomCenter(const Offset(0, -170)), 5, blackLinePaint);

    // 鼻子
    canvas.drawCircle(size.bottomCenter(const Offset(0, -255)), 5, blackNosePaint);

    // 雪花
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
