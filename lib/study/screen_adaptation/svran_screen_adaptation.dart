import 'package:flutter/material.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class ScreenAdaptationPage extends StatefulWidget {
  const ScreenAdaptationPage({Key? key}) : super(key: key);

  @override
  State<ScreenAdaptationPage> createState() => _ScreenAdaptationPageState();
}

class _ScreenAdaptationPageState extends State<ScreenAdaptationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("屏幕适配"),
        ),
        body: Center(
          child: Container(
            color: Colors.red.withAlpha(0x30),
            child: Column(
              children: [
                Container(
                  width: 200.rpx,
                  height: 200.rpx,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ));
  }
}
