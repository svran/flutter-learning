import 'dart:math';

import 'package:flutter/material.dart';

class AminCustomPainterDemoPage extends StatefulWidget {
  const AminCustomPainterDemoPage({Key? key}) : super(key: key);

  @override
  State<AminCustomPainterDemoPage> createState() => _AminCustomPainterDemoPageState();
}

class _AminCustomPainterDemoPageState extends State<AminCustomPainterDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<Snowflake> list = List.generate(150, (index) => Snowflake());

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
  final hatPaint = Paint()..color = Colors.red;
  final blackLinePaint = Paint()
    ..strokeWidth = 1
    ..color = Colors.black
    ..style = PaintingStyle.stroke;
  final blackLineHandPaint = Paint()
    ..strokeWidth = 4
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;
  final fingerPaint = Paint()
    ..strokeWidth = 2
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    // logger.d("Svran: Flutter -> ${size.width} , ${size.height}");
    // Offset(size.width / 2, size.height / 2) 等于 size.center(Offset.zero)

    // 身子
    canvas.drawOval(
        Rect.fromCenter(center: size.bottomCenter(const Offset(0, -100)), width: 200, height: 250), whitePaint);

    // 围巾
    canvas.drawCircle(size.bottomCenter(const Offset(0, -230)), 60.0, hatPaint);

    // 头
    canvas.drawCircle(size.bottomCenter(const Offset(0, -250)), 60.0, whitePaint);

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
    // 左手手指
    var leftStartPoint = size.bottomCenter(const Offset(-130, -230));
    canvas.drawLine(leftStartPoint, Offset(leftStartPoint.dx - 10, leftStartPoint.dy - 15), fingerPaint);
    canvas.drawLine(leftStartPoint, Offset(leftStartPoint.dx - 15, leftStartPoint.dy - 10), fingerPaint);
    canvas.drawLine(leftStartPoint, Offset(leftStartPoint.dx - 15, leftStartPoint.dy), fingerPaint);
    // 右手手指
    var rightStartPoint = size.bottomCenter(const Offset(130, -230));
    canvas.drawLine(rightStartPoint, Offset(rightStartPoint.dx + 10, rightStartPoint.dy + 15), fingerPaint);
    canvas.drawLine(rightStartPoint, Offset(rightStartPoint.dx + 15, rightStartPoint.dy + 10), fingerPaint);
    canvas.drawLine(rightStartPoint, Offset(rightStartPoint.dx + 15, rightStartPoint.dy), fingerPaint);

    // 扣子三颗
    double buttonBaseHeight = -90.0;
    canvas.drawCircle(size.bottomCenter(Offset(0, buttonBaseHeight)), 5, blackLinePaint);
    canvas.drawCircle(size.bottomCenter(Offset(0, buttonBaseHeight - 30)), 5, blackLinePaint);
    canvas.drawCircle(size.bottomCenter(Offset(0, buttonBaseHeight - 60)), 5, blackLinePaint);

    // 鼻子
    canvas.drawCircle(size.bottomCenter(const Offset(0, -255)), 5, blackNosePaint);
    var nosePath = Path();
    var nPoint = size.bottomCenter(Offset(0, -255));
    nosePath.moveTo(nPoint.dx, nPoint.dy - 5); // 起点
    nosePath.relativeLineTo(-20, 5); // 左边顶点
    nosePath.relativeLineTo(20, 5); // 下边顶点
    canvas.drawPath(nosePath, blackNosePaint);

    // 帽子
    canvas.drawCircle(size.bottomCenter(Offset(50, -380)), 10, hatPaint);
    var hatPath = Path();
    var hatPoint = size.bottomCenter(Offset(50, -380));
    hatPath.moveTo(hatPoint.dx, hatPoint.dy);
    hatPath.relativeLineTo(-60, 70);
    hatPath.relativeLineTo(60, 28);
    canvas.drawPath(hatPath, hatPaint);

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
  double radius = Random().nextDouble() * 1 + 3;
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
