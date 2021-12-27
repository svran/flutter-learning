import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';

import '../public_code.dart';

/// 仿制效果 : https://www.qiyuandi.com/zhanzhang/zonghe/14066.html 网页的点击特效
class SvranBoomCanvasPage extends StatefulWidget {
  const SvranBoomCanvasPage({Key? key}) : super(key: key);

  @override
  State<SvranBoomCanvasPage> createState() => _SvranBoomCanvasPageState();
}

class _SvranBoomCanvasPageState extends State<SvranBoomCanvasPage> {
  int pointCount = 60;

  _changePoint(int addCount) {
    pointCount += addCount;
    if (pointCount >= 5000) {
      pointCount = 5000;
    }
    if (pointCount < 0) {
      pointCount = 10;
    }
    svranToast("点数:$pointCount");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("点击Boom效果"),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "add100",
            tooltip: "增加100个点",
            child: const Icon(Icons.add_circle_outline),
            onPressed: () => _changePoint(100),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: "add",
            tooltip: "增加10个点",
            child: const Icon(Icons.add),
            onPressed: () => _changePoint(10),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: "sub",
            tooltip: "减少10个点",
            child: const Icon(Icons.remove),
            onPressed: () => _changePoint(-10),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: "refresh",
            tooltip: "减少10个点",
            child: const Icon(Icons.refresh),
            onPressed: () {
              pointCount = 60;
              svranToast("点数:$pointCount");
              setState(() {});
            },
          ),
        ],
      ),
      body: SvranClickBoomWidget(
        longPressBoomDuration: const Duration(seconds: 1),
        pointCount: pointCount,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                svranToast("点击了这个按钮");
              },
              child: Text('点击'),
            ),
            Text('这效果是使用 CustomPaint 自己在Canvas中绘制而成.\n 现在点数: $pointCount'),
          ],
        )),
      ),
    );
  }
}

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
    logger.d("Svran: Flutter -> 长按抬起");
    _big = true;
    if (details != null) pressPoint = details.localPosition;
    var durationTime = DateTime.now().difference(startTime).inMilliseconds;
    if (durationTime >= widget.longPressBoomDuration.inMilliseconds) {
      durationTime = widget.longPressBoomDuration.inMilliseconds;
    }
    for (var element in circles) {
      double s = (durationTime / widget.longPressBoomDuration.inMilliseconds);
      var baseDistance = widget.minDistance + (constraints.biggest.shortestSide - widget.minDistance) * s;
      element.reset(pressPoint, baseDistance: baseDistance);
    }
    _controller.forward(from: 0.0);
  }

  _tapDown(BoxConstraints constraints, details) {
    logger.d("Svran: Flutter -> 按下 $constraints -> ${details.localPosition}");
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
  Color color = randomColor(); // 颜色
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
    color = randomColor();
    var dx = point.dx + distance * cos(radian);
    var dy = point.dy + distance * sin(radian);
    offset = Offset(dx, dy);
    // logger.d("Svran: Flutter -> 起点:$point 终点:$offset 距离:$distance 半径:$r -> rr:$rr");
  }
}

// randomColor() {
//   return Color.fromARGB(
//     255,
//     Random.secure().nextInt(255),
//     Random.secure().nextInt(255),
//     Random.secure().nextInt(255),
//   );
// }
