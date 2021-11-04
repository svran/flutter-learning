import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class AnimatedNumberDemoPage extends StatefulWidget {
  const AnimatedNumberDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimatedNumberDemoPage> createState() => _AnimatedNumberDemoPageState();
}

class _AnimatedNumberDemoPageState extends State<AnimatedNumberDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("计数器"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 120,
          color: Colors.blue,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 1),
            tween: Tween(begin: 7.0, end: 6.0),
            builder: (context, value, child) {
              // logger.d("Svran: Flutter -> value: $value");
              final whole = value ~/ 1;
              final decimal = value - whole;
              logger.d("Svran: Flutter -> $whole + $decimal");
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
          ),
        ),
      ),
    );
  }
}
