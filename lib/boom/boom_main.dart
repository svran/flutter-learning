import 'dart:math';

import 'package:flutter/material.dart';

import '../public_code.dart';

/// 仿制效果 : https://www.qiyuandi.com/zhanzhang/zonghe/14066.html 网页的点击特效
class SvranBoomMainPage extends StatefulWidget {
  const SvranBoomMainPage({Key? key}) : super(key: key);

  @override
  State<SvranBoomMainPage> createState() => _SvranBoomMainPageState();
}

class _SvranBoomMainPageState extends State<SvranBoomMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("点击Boom效果"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: const SvranClickBoomWidget(
        longPressBoomDuration: Duration(seconds: 1),
        pointCount: 60,
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
    logger.d("Svran: Flutter -> 按下");
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
            builder: (BuildContext context, child) {
              final List<Widget> widgets = circles.sublist(0, _big ? circles.length : widget.pointCount).map((e) {
                return _PointWidget(
                  circle: e,
                  controller: _controller,
                  pressPoint: pressPoint,
                  duration: widget.duration,
                  maxRadius: widget.pointMaxRadius,
                  big: _big,
                );
              }).toList();
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue[300],
                child: Stack(
                  fit: StackFit.expand,
                  children: widgets,
                ),
              );
            },
            animation: _controller,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _PointWidget extends StatelessWidget {
  final AnimationController controller;
  final Offset pressPoint;
  final Duration duration;
  final double maxRadius;
  final _Circle circle;
  final bool big;

  const _PointWidget({
    Key? key,
    required this.controller,
    required this.circle,
    required this.pressPoint,
    required this.duration,
    required this.maxRadius,
    required this.big,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offset = Tween(begin: pressPoint, end: circle.offset) //
        .chain(CurveTween(curve: Curves.easeOutCirc)) //
        .animate(controller)
        .value;
    final curveR = (circle.r / maxRadius) > 0.6 ? (big ? Curves.easeOutQuad : Curves.easeOut) : Curves.easeOutBack;
    final r = Tween(begin: 0.0, end: 1.0) //
        .chain(CurveTween(curve: curveR)) //
        .animate(controller)
        .value;
    return Positioned(
      left: offset.dx - (1 - r) * circle.r / 2,
      top: offset.dy - (1 - r) * circle.r / 2,
      child: Container(
        height: (1 - ((r >= 1) ? 1 : r)) * circle.r,
        width: (1 - ((r >= 1) ? 1 : r)) * circle.r,
        decoration: BoxDecoration(color: circle.color, shape: BoxShape.circle),
      ),
    );
  }
}

class _Circle {
  double r = 0; // 半径
  double distance = 0; // 距离
  double radian = 0; // 弧度
  Color color = randomColor(); // 颜色
  Offset offset = Offset.zero; // 坐标

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
