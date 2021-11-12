import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../public_code.dart';

class GameStreamDemoPage extends StatefulWidget {
  const GameStreamDemoPage({Key? key}) : super(key: key);

  @override
  State<GameStreamDemoPage> createState() => _GameStreamDemoPageState();
}

class _GameStreamDemoPageState extends State<GameStreamDemoPage> {
  final _inputController = StreamController.broadcast();
  final _scoreController = StreamController.broadcast();

  @override
  void initState() {
    RawKeyboard.instance.addListener(_onKey);
    super.initState();
  }

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      return;
    }

    final key = event.data.logicalKey;

    logger.d("Svran: Flutter -> key:$key");

    if (key == LogicalKeyboardKey.escape) {
      Navigator.pop(context);
    } else {
      if (key == LogicalKeyboardKey.numpad1) {
        _inputController.sink.add(1);
      } else if (key == LogicalKeyboardKey.numpad2) {
        _inputController.sink.add(2);
      } else if (key == LogicalKeyboardKey.numpad3) {
        _inputController.sink.add(3);
      } else if (key == LogicalKeyboardKey.numpad4) {
        _inputController.sink.add(4);
      } else if (key == LogicalKeyboardKey.numpad5) {
        _inputController.sink.add(5);
      } else if (key == LogicalKeyboardKey.numpad6) {
        _inputController.sink.add(6);
      } else if (key == LogicalKeyboardKey.numpad7) {
        _inputController.sink.add(7);
      } else if (key == LogicalKeyboardKey.numpad8) {
        _inputController.sink.add(8);
      } else if (key == LogicalKeyboardKey.numpad9) {
        _inputController.sink.add(9);
      }
    }
  }

  @override
  void dispose() {
    _inputController.close();
    _scoreController.close();
    RawKeyboard.instance.removeListener(_onKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<int>(
          stream: _scoreController.stream.transform(TallyTransformer<dynamic, int>()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('数学计算小游戏 分数:${snapshot.data}');
            }
            return const Text('数学计算小游戏');
          },
        ),
      ),
      body: Stack(
        children: [
          ...List.generate(
              15,
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

class TallyTransformer<d, i> implements StreamTransformer<d, i> {
  int sum = 0;
  final StreamController<i> _controller = StreamController();

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() {
    return StreamTransformer.castFrom(this);
  }

  @override
  Stream<i> bind(Stream<d> stream) {
    stream.listen((event) {
      sum += (event as int);
      _controller.add(sum as i);
    });
    return _controller.stream;
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
  final Stream inputStream;
  final StreamController scoreStream;
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
              color: color.withOpacity(0.5),
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
