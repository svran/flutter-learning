import 'dart:math';

import 'package:flutter/material.dart';

import '../../../public_code.dart';

class KeyColorGameDemoPage extends StatefulWidget {
  const KeyColorGameDemoPage({Key? key}) : super(key: key);

  @override
  State<KeyColorGameDemoPage> createState() => _KeyColorGameDemoPageState();
}

class _KeyColorGameDemoPageState extends State<KeyColorGameDemoPage> {
  MaterialColor color = Colors.blue;
  List<Color> colors = []; // = List.generate(8, (index) => color[(index + 1) * 100]);

  int slot = 0;

  _shuffle() {
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    colors = List.generate(8, (index) => color[(index + 1) * 100]!);
    setState(() => colors.shuffle());
  }

  _checkWinCondition() {
    var cc = colors.map((c) => c.computeLuminance()).toList();
    logger.d("Svran: Flutter -> $cc");
    bool success = true;
    for (var i = 0; i < cc.length - 1; ++i) {
      if (cc[i] > cc[i + 1]) {
        success = false;
        break;
      }
    }
    logger.w("Svran: Flutter -> 胜利? : $success");
  }

  final _appBarKey = GlobalKey();
  double offset = 0.0;

  @override
  void initState() {
    _shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("颜色排序小游戏"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _shuffle,
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text('颜色排序小游戏', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 32),
            Container(
              // 默认显示样式
              width: Box.width,
              height: Box.height - Box.margin * 2,
              decoration: BoxDecoration(
                color: color[900],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.lock, color: Colors.white),
            ),
            Expanded(
              child: Listener(
                onPointerMove: (event) {
                  final y = event.position.dy - offset;
                  if (y > (slot + 1) * Box.height) {
                    if (slot >= colors.length - 1) return;
                    setState(() {
                      final c = colors[slot];
                      colors[slot] = colors[slot + 1];
                      colors[slot + 1] = c;
                      slot++;
                    });
                  } else if (y < (slot * Box.height)) {
                    if (slot <= 0) return;
                    setState(() {
                      final c = colors[slot];
                      colors[slot] = colors[slot - 1];
                      colors[slot - 1] = c;
                      slot--;
                    });
                  }
                },
                child: SizedBox(
                  width: 266,
                  child: Stack(
                    key: _appBarKey,
                    children: List.generate(
                      colors.length,
                      (i) {
                        return Box(
                          key: ValueKey(colors[i]),
                          color: colors[i],
                          y: i * 50,
                          onEnd: _checkWinCondition,
                          onDrag: (color) {
                            final index = colors.indexOf(color);
                            // logger.d("Svran: Flutter -> 拖动了: $index");
                            final rb = _appBarKey.currentContext?.findRenderObject() as RenderBox;
                            offset = rb.localToGlobal(Offset.zero).dy;
                            slot = index;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  static const width = 250.0;
  static const height = 50.0;
  static const margin = 2.0;

  final Function(Color) onDrag;
  final Function() onEnd;

  final Color color;
  final double x, y;

  const Box({Key? key, required this.color, this.x = 0, this.y = 0, required this.onDrag, required this.onEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = Container(
      // 默认显示样式
      margin: const EdgeInsets.all(8.0),
      width: width,
      height: height - margin * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      left: x,
      top: y,
      child: Draggable(
        onDragEnd: (details) => onEnd(),
        onDragStarted: () => onDrag(color),
        child: container,
        feedback: container,
        childWhenDragging: Visibility(
          visible: false,
          child: container,
        ),
      ),
    );
  }
}

//          final x = event.position.dx;
//           // logger.d("Svran: Flutter -> 坐标x: $x");
//           if (x > (slot + 1) * Box.width) {
//             if (slot >= colors.length - 1) return;
//             setState(() {
//               final c = colors[slot];
//               colors[slot] = colors[slot + 1];
//               colors[slot + 1] = c;
//               slot++;
//             });
//           } else if (x < (slot * Box.width)) {
//             if (slot <= 0) return;
//             setState(() {
//               final c = colors[slot];
//               colors[slot] = colors[slot - 1];
//               colors[slot - 1] = c;
//               slot--;
//             });
//           }

// 最简单的实现方式:
// ReorderableListView(
//           onReorder: (int oldIndex, int newIndex) {
//             if (newIndex > oldIndex) newIndex--;
//             final element = boxes.removeAt(oldIndex);
//             boxes.insert(newIndex, element);
//           },
//           children: boxes,
//         )

// class Box extends StatelessWidget {
//   final Color? color;
//
//   const Box({Key? key, required this.color}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       width: 50,
//       height: 50,
//       color: color,
//     );
//   }
// }
