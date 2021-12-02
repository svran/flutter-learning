import 'dart:math';

import 'package:flutter/material.dart';

class SvranGameBloodBar extends StatefulWidget {
  final double max;
  final double current;
  final double height;
  final double borderWidth;
  final Color color;
  final Color borderColor;
  final Color backColor;
  final Duration duration;

  SvranGameBloodBar({
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
  _SvranGameBloodBarState createState() => _SvranGameBloodBarState();
}

class _SvranGameBloodBarState extends State<SvranGameBloodBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;
        final double currentWidth = maxWidth * (widget.current / widget.max);
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
