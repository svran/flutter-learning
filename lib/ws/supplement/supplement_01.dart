import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class ThreeDBallPage extends StatefulWidget {
  const ThreeDBallPage({Key? key}) : super(key: key);

  @override
  State<ThreeDBallPage> createState() => _ThreeDBallPageState();
}

class _ThreeDBallPageState extends State<ThreeDBallPage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("写个球"),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            logger.d("Svran: Flutter -> ${details.delta}");
            _offset += details.delta;
          });
        },
        child: CustomPaint(
          size: const Size(400, 400),
          painter: MyPainter(rx: _offset.dy * 0.01, ry: _offset.dx * 0.01, rz: 0.0),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double rx, ry, rz;

  MyPainter({required this.rx, required this.ry, required this.rz});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    const double radius = 150;
    const int resolution = 100;
    for (var i = 0; i < resolution; ++i) {
      final theta = pi * i / resolution;
      for (var j = 0; j < resolution; ++j) {
        final phi = 2 * pi * j / resolution;
        final x = radius * cos(phi) * sin(theta);
        final y = radius * sin(phi) * sin(theta);
        final z = radius * cos(theta);

        double rxx = x;
        double rxy = cos(rx) * y + sin(rx) * z;
        double rxz = -sin(rx) * y + cos(rx) * z;

        double ryx = cos(ry) * rxx - sin(ry) * rxz;
        double ryy = rxy;
        double ryz = sin(ry) * rxx + cos(ry) * rxz;

        double rzx = cos(rz) * ryx - sin(rz) * ryy;
        double rzy = sin(rz) * ryx + cos(rz) * ryy;
        double rzz = ryz;

        canvas.drawCircle(Offset(rzx, rzy), 0.6,
            Paint()..color = Color.fromARGB(255, 255, i * 255 ~/ resolution, j * 255 ~/ resolution));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
