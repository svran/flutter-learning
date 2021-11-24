import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';

class SvranBloodBarDemoPage extends StatefulWidget {
  const SvranBloodBarDemoPage({Key? key}) : super(key: key);

  @override
  State<SvranBloodBarDemoPage> createState() => _SvranBloodBarDemoPageState();
}

class _SvranBloodBarDemoPageState extends State<SvranBloodBarDemoPage> {
  double blood = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("血条效果"),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "add",
            tooltip: "加",
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                blood += 10;
              });
            },
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            tooltip: "减",
            heroTag: "sub",
            child: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                blood -= 10;
              });
            },
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            tooltip: "满",
            heroTag: "max",
            child: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                blood = 100;
              });
            },
          )
        ],
      ),
      body: Center(
        child: SvranBloodBar(
          current: blood,
          duration: Duration(milliseconds: 500),
          height: 20,
        ),
      ),
    );
  }
}

class SvranBloodBar extends StatefulWidget {
  final double max;
  final double current;
  final double height;
  final double borderWidth;
  final Color color;
  final Color borderColor;
  final Color backColor;
  final Duration duration;

  SvranBloodBar({
    Key? key,
    this.max = 100,
    this.current = 0,
    this.height = 15,
    this.color = Colors.red,
    this.borderWidth = 1,
    this.borderColor = Colors.blue,
    Color? backColor,
    Duration? duration,
  })  : duration = duration ?? const Duration(seconds: 1),
        backColor = backColor ?? Colors.red.withOpacity(0.5),
        super(key: key);

  @override
  _SvranBloodBarState createState() => _SvranBloodBarState();
}

class _SvranBloodBarState extends State<SvranBloodBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        final double currentWidth = maxWidth * (widget.current / widget.max);
        svranToast("$maxWidth / $currentWidth");
        return Container(
          width: max(maxWidth, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(max(widget.height, 0)),
            border: Border.all(color: Colors.blue, width: widget.borderWidth),
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: widget.duration,
                height: max(widget.height, 0),
                width: max(currentWidth, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(max(widget.height, 0)),
                  color: widget.color.withOpacity(0.5),
                ),
              ),
              Container(
                height: max(widget.height, 0),
                width: max(currentWidth, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(max(widget.height, 0)),
                  color: widget.color,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '${widget.current}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        shadows: [Shadow(color: Colors.white, offset: Offset(0.5, 0.5), blurRadius: 0.3)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
