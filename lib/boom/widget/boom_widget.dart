import 'dart:math';

import 'package:flutter/material.dart';

/// 点击特效
class SvranClickBoomWidget extends StatefulWidget {
  final int pointCount;
  final Duration duration;
  final AnimationController? controller;
  final double minDistance;
  final Duration longPressBoomDuration;
  final double pointMaxRadius;
  final Widget? child;

  const SvranClickBoomWidget({
    Key? key,
    int? pointCount,
    Duration? duration,
    double? minDistance,
    Duration? longPressBoomDuration,
    double? pointMaxRadius,
    this.child,
    this.controller,
  })  : pointCount = pointCount ?? 30,
        duration = duration ?? const Duration(seconds: 1),
        longPressBoomDuration = longPressBoomDuration ?? const Duration(seconds: 3),
        minDistance = minDistance ?? 150.0,
        pointMaxRadius = pointMaxRadius ?? 50.0,
        super(key: key);

  @override
  _SvranClickBoomWidgetState createState() => _SvranClickBoomWidgetState();
}

class _SvranClickBoomWidgetState extends State<SvranClickBoomWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Offset pressPoint = Offset.zero;
  DateTime startTime = DateTime.now();

  List<_Circle> circles = []; //
  bool _big = false;

  @override
  void initState() {
    _controller = widget.controller ?? AnimationController(vsync: this, duration: widget.duration);
    circles = List.generate((widget.pointCount * 3), (index) => _Circle());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _longPressUp(BoxConstraints constraints, {details}) {
    _big = true;
    if (details != null) pressPoint = details.localPosition;
    var durationTime = DateTime.now().difference(startTime).inMilliseconds;
    if (durationTime >= widget.longPressBoomDuration.inMilliseconds) {
      durationTime = widget.longPressBoomDuration.inMilliseconds;
    }
    for (var element in circles) {
      double s = (durationTime / widget.longPressBoomDuration.inMilliseconds);
      var baseDistance = widget.minDistance + (constraints.biggest.longestSide - widget.minDistance) * s;
      element.reset(pressPoint, baseDistance: baseDistance);
    }
    _controller.forward(from: 0.0);
  }

  _tapDown(BoxConstraints constraints, details) {
    _big = false;
    pressPoint = details.localPosition;
    for (var i = 0; i < circles.length; i++) {
      var element = circles[i];
      if (i == widget.pointCount) break;
      element.reset(pressPoint, radius: widget.pointMaxRadius, baseDistance: widget.minDistance);
    }
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    if (circles.length != widget.pointCount * 3) {
      circles = List.generate((widget.pointCount * 3), (index) => _Circle());
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          // onLongPressCancel: () => _longPressUp(constraints),
          // onTapDown: (details) => _tapDown(constraints, details),
          onPanDown: (details) => _tapDown(constraints, details),
          onPanEnd: (details) => _longPressUp(constraints),
          onPanStart: (details) => startTime = DateTime.now(),
          onPanUpdate: (details) => pressPoint = details.localPosition,
          onLongPressMoveUpdate: (details) => pressPoint = details.localPosition,
          onTapUp: (details) => pressPoint = details.localPosition,
          onLongPressStart: (details) => startTime = DateTime.now(),
          onLongPressUp: () => _longPressUp(constraints),
          child: AnimatedBuilder(
            animation: _controller,
            child: widget.child,
            builder: (BuildContext context, child) {
              final List<_Circle> pts = circles.sublist(0, _big ? circles.length : widget.pointCount);
              for (int i = 0; i < pts.length; i++) {
                var circle = pts[i];
                final offset = Tween(begin: pressPoint, end: circle.offset) //
                    .chain(CurveTween(curve: Curves.easeOutCirc)) //
                    .animate(_controller)
                    .value;
                final curveR = (circle.r / widget.pointMaxRadius) > 0.6
                    ? (_big ? Curves.easeOutQuad : Curves.easeOut)
                    : Curves.easeOutBack;
                final r = Tween(begin: 0.0, end: 1.0) //
                    .chain(CurveTween(curve: curveR)) //
                    .animate(_controller)
                    .value;
                circle.offsetCurrent = offset;
                circle.rCurrent = (1 - ((r >= 1) ? 1 : r)) * circle.r / 2;
              }
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: CustomPaint(
                  child: child,
                  painter: _PointPainter(circles: pts),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _PointPainter extends CustomPainter {
  List<_Circle> circles;

  _PointPainter({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.blue[100]!, BlendMode.color);
    for (var c in circles) {
      canvas.drawCircle(c.offsetCurrent, c.rCurrent, Paint()..color = c.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Circle {
  double r = 0; // 半径
  double distance = 0; // 距离
  double radian = 0; // 弧度
  Color color = _randomColor(); // 颜色
  Offset offset = Offset.zero; // 坐标
  Offset offsetCurrent = Offset.zero; // 坐标
  double rCurrent = 0; // 半径

  @override
  String toString() {
    return '_Circle{offsetCurrent: $offsetCurrent, rCurrent: $rCurrent}';
  }

  reset(Offset point, {double baseDistance = 150, double radius = 50}) {
    if (radius <= 20) radius = 20;
    r = radius - (Random().nextDouble() * (radius - radius * 0.2));
    distance = baseDistance - Random().nextDouble() * (baseDistance - baseDistance * 0.4);
    radian = Random().nextDouble() * 2 * pi;
    color = _randomColor();
    var dx = point.dx + distance * cos(radian);
    var dy = point.dy + distance * sin(radian);
    offset = Offset(dx, dy);
    // logger.d("Svran: Flutter -> 起点:$point 终点:$offset 距离:$distance 半径:$r -> rr:$rr");
  }
}

_randomColor() {
  return Color.fromARGB(
    255,
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
  );
}
