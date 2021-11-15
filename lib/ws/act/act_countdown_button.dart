import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ActCountdownButtonDemoPage extends StatefulWidget {
  const ActCountdownButtonDemoPage({Key? key}) : super(key: key);

  @override
  State<ActCountdownButtonDemoPage> createState() => _ActCountdownButtonDemoPageState();
}

class _ActCountdownButtonDemoPageState extends State<ActCountdownButtonDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("倒计时按钮"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountdownButton(duration: Duration(seconds: 5), width: 200, height: 100, radius: 50),
            SizedBox(height: 20),
            CountdownButton(duration: Duration(seconds: 5), width: 100, height: 100, radius: 100),
            SizedBox(height: 20),
            CountdownButton(duration: Duration(seconds: 5), width: 200, height: 100, radius: 0),
          ],
        ),
      ),
    );
  }
}

class CountdownButton extends StatefulWidget {
  final Duration duration;
  final double width, height, radius;

  const CountdownButton({
    Key? key,
    required this.duration,
    required this.width,
    required this.height,
    required this.radius,
  }) : super(key: key);

  @override
  _CountdownButtonState createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _stage = 0; // 0 准备,1 可取消, 2 完成

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _stage = 2;
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String label = "";
    Color? textColor;
    Color? bgColor;

    switch (_stage) {
      case 0:
        label = "Send";
        textColor = Colors.white;
        bgColor = Colors.blue;
        break;
      case 1:
        label = "Cancel";
        break;
      case 2:
        label = "Done";
        textColor = Colors.grey;
        break;
    }

    return Stack(
      children: [
        CustomPaint(
          painter: BorderPainter(
            buttonWidth: widget.width,
            buttonHeight: widget.height,
            buttonRadius: widget.radius,
            animation: _controller,
          ),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextButton(
            onPressed: () {
              if (_stage == 0) {
                _controller.forward(from: 0.0);
                setState(() {
                  _stage = 1;
                });
              } else {
                _controller.reset();
                setState(() {
                  _stage = 0;
                });
              }
            },
            child: Text(label),
            style: TextButton.styleFrom(
                primary: textColor,
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                )),
          ),
        )
      ],
    );
  }
}

class BorderPainter extends CustomPainter {
  final double buttonWidth;
  final double buttonHeight;
  final double buttonRadius;
  final Animation<double> animation;

  final Paint bluePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.9
    ..color = Colors.blue;

  final Paint greyPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0
    ..color = Colors.grey;

  late RRect shape;
  late PathMetric pathMetric;

  BorderPainter({
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonRadius,
    required this.animation,
  }) : super(repaint: animation) {
    shape = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: buttonWidth, height: buttonHeight),
      Radius.circular(buttonRadius),
    );
    final path = Path()..addRRect(shape); // 把圆角矩形,转换为路径
    pathMetric = path.computeMetrics().single; // 获取path的第一项
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final totalLength = pathMetric.length;
    final currentLength = totalLength * animation.value;
    final startingPoint = totalLength / 4 + max(buttonHeight / 2 - buttonRadius, 0);

    // extractPath 类似于 String.subString方法.

    // path.addPath(pathMetric.extractPath(0, currentLength), Offset.zero);

    // 修正 起点为最左边的中间开始问题
    path.addPath(pathMetric.extractPath(startingPoint, currentLength + startingPoint), Offset.zero);
    path.addPath(pathMetric.extractPath(0.0, currentLength - (totalLength - startingPoint)), Offset.zero);

    canvas.translate(buttonWidth / 2, buttonHeight / 2);
    canvas.drawRRect(shape, bluePaint);
    canvas.drawPath(path, greyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
