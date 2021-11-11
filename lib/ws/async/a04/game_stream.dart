import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GameStreamDemoPage extends StatefulWidget {
  const GameStreamDemoPage({Key? key}) : super(key: key);

  @override
  State<GameStreamDemoPage> createState() => _GameStreamDemoPageState();
}

class _GameStreamDemoPageState extends State<GameStreamDemoPage> {
  final _inputController = StreamController<int>.broadcast();
  final _scoreController = StreamController<int>.broadcast();

  int score = 0;

  @override
  void initState() {
    _inputController.stream.listen((event) {});
    _scoreController.stream.listen((event) {});
    super.initState();
  }

  @override
  void dispose() {
    _inputController.close();
    _scoreController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<int>(
          stream: _scoreController.stream,//.transform(streamTransformer),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              score += (snapshot.data ?? 0);
            }
            return Text('数学计算小游戏 分数:$score');
          },
        ),
      ),
      body: Stack(
        children: [
          ...List.generate(
              5,
              (index) => Puzzle(
                    inputStream: _inputController.stream,
                    scoreStream: _scoreController,
                    w: w,
                  )),
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(controller: _inputController),
          ),
        ],
      ),
    );
  }
}

class TallyTransformer implements StreamTransformer {
  int sum = 0;
  StreamController _controller = StreamController();

  @override
  Stream bind(Stream<dynamic> stream) {
    stream.listen((event) {
      sum += (event as int);
      _controller.add(sum);
    });
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() {
    return StreamTransformer.castFrom(this);
  }
}

class KeyPad extends StatelessWidget {
  final StreamController controller;

  const KeyPad({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(5.0),
      shrinkWrap: true,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      childAspectRatio: 2 / 1,
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        return ElevatedButton(
          onPressed: () {
            controller.add(index + 1);
          },
          child: Text('${index + 1}', style: const TextStyle(fontSize: 24)),
        );
      }),
    );
  }
}

class Puzzle extends StatefulWidget {
  final Stream<int> inputStream;
  final StreamController<int> scoreStream;
  final double w;

  const Puzzle({
    Key? key,
    required this.inputStream,
    required this.scoreStream,
    required this.w,
  }) : super(key: key);

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late int a, b;
  late Color color;
  late double x;

  reset([from = 0.0]) {
    a = Random().nextInt(9);
    b = Random().nextInt(9 - a);
    if (a + b == 0) {
      a++;
    }
    x = Random().nextDouble() * (widget.w - 100);
    _controller.duration = Duration(seconds: 5 + Random().nextInt(5));
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _controller.forward(from: from);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
    reset(Random().nextDouble());
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        widget.scoreStream.add(-3);
      }
    });
    widget.inputStream.listen((event) {
      if (event == a + b) {
        reset();
        widget.scoreStream.add(5);
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          top: 550 * _controller.value - 100,
          left: x,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black),
            ),
            child: Text('$a + $b', style: const TextStyle(fontSize: 24)),
          ),
        );
      },
    );
  }
}
