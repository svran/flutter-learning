import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;

  const AnimatedCounter({Key? key, required this.value, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      // 最初运行的时候, begin开始, 之后就从当前值变化为end值, 忽略begin ,就自动将end 复制一份作为begin
      tween: Tween(end: value.toDouble()),
      builder: (context, value, child) {
        // logger.d("Svran: Flutter -> value: $value");
        final whole = value ~/ 1;
        final decimal = value - whole;
        return Stack(
          children: [
            Positioned(
              top: -100 * decimal,
              child: Opacity(
                opacity: 1.0 - decimal,
                child: Text(
                  '$whole',
                  style: TextStyle(fontSize: 100),
                ),
              ),
            ),
            Positioned(
              top: 100 - decimal * 100,
              child: Opacity(
                opacity: decimal,
                child: Text(
                  '${whole + 1}',
                  style: TextStyle(fontSize: 100),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
