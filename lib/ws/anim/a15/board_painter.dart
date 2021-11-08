import 'package:flutter/material.dart';

import '../../../public_code.dart';

class BoardPainterDemoPage extends StatefulWidget {
  const BoardPainterDemoPage({Key? key}) : super(key: key);

  @override
  State<BoardPainterDemoPage> createState() => _BoardPainterDemoPageState();
}

// 现成的在 pub.dev 中也有, signature

class _BoardPainterDemoPageState extends State<BoardPainterDemoPage> {
  List<Offset?> _points = <Offset?>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("手绘板"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.clear),
        onPressed: () {
          setState(() {
            logger.d("Svran: Flutter -> 清空了");
            _points.clear();
          });
        },
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue[100],
        child: GestureDetector(
          onPanUpdate: (details) => _addPoint(details),
          onPanEnd: (details) => _points.add(null),
          child: CustomPaint(
            painter: BoardPainter(_points),
          ),
        ),
      ),
    );
  }

  _addPoint(DragUpdateDetails details) {
    Offset localPosition = details.localPosition;
    setState(() {
      _points = List.from(_points)..add(localPosition);
    });
  }
}

class BoardPainter extends CustomPainter {
  BoardPainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) => oldDelegate.points != points;
}
