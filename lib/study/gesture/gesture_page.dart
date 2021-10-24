import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/public_code.dart';

class GestureDemoPage extends StatefulWidget {
  const GestureDemoPage({Key? key}) : super(key: key);

  @override
  State<GestureDemoPage> createState() => _GestureDemoPageState();
}

class _GestureDemoPageState extends State<GestureDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("事件监听"),
        ),
        body: Center(
          child: GestureDetector(
            onTapDown: (details) {
              logger.d("Svran: Flutter -> out container click");
            },
            child: Container(
              width: 300,
              height: 300,
              color: Colors.red,
              alignment: Alignment.center,
              // 阻止 手势传递
              child: IgnorePointer(
                child: GestureDetector(
                  onTapDown: (details) {
                    logger.d("Svran: Flutter -> inner container click");
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

// 大Container中包裹小的Container,小的Container会自动撑满到大Container.
// 只要大Container添加一个Alignment 即可

class GestureDemoWidget extends StatelessWidget {
  const GestureDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        svranToast("onTap");
      },
      onTapDown: (detail) {
        svranToast("onTapDown : ${detail.localPosition}");
      },
      onLongPress: () {
        svranToast("长按");
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.orange.withAlpha(0x60),
      ),
    );
  }
}

class ListenerDemoWidget extends StatelessWidget {
  const ListenerDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        // position 相对于屏幕的坐标点
        logger.d("Svran: Flutter -> 按下 ${event.position} ,${event.localPosition}");
      },
      onPointerMove: (event) {
        logger.d("Svran: Flutter -> 移动");
      },
      onPointerUp: (event) {
        logger.d("Svran: Flutter -> 抬起");
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red.withAlpha(0x60),
      ),
    );
  }
}
