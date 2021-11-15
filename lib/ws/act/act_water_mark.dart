import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActWaterMarkDemoPage extends StatefulWidget {
  const ActWaterMarkDemoPage({Key? key}) : super(key: key);

  @override
  State<ActWaterMarkDemoPage> createState() => _ActWaterMarkDemoPageState();
}

class _ActWaterMarkDemoPageState extends State<ActWaterMarkDemoPage> {
  @override
  Widget build(BuildContext context) {
    String? watermark = "付费内容,暂时隐藏\n请支付1w RMB再看?";
    return Scaffold(
      appBar: AppBar(
        title: const Text("水印覆盖效果"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 200, child: TextWaterMark01(watermark: watermark)),
          SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(child: TextWaterMark01(watermark: watermark)),
                  Expanded(child: TextWaterMark01(watermark: watermark)),
                ],
              )),
          SizedBox(height: 200, child: TextWaterMark01(watermark: watermark)),
        ],
      ),
    );
  }
}

class TextWaterMark01 extends StatelessWidget {
  final String? watermark;

  const TextWaterMark01({Key? key, this.watermark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: watermark == null ? 0 : 2, sigmaY: watermark == null ? 0 : 2),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                ),
              ),
            ),
          ),
        ),
        if (watermark != null)
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Transform.rotate(
                angle: -pi / 4,
                child: FittedBox(
                  child: Text(watermark!),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TextWaterMark00 extends StatelessWidget {
  final String? watermark;

  const TextWaterMark00({Key? key, this.watermark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: watermark == null ? 0 : 2, sigmaY: watermark == null ? 0 : 2),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                ),
              ),
            ),
          ),
        ),
        if (watermark != null)
          LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SizedBox(
                  width: constraints.biggest.shortestSide,
                  height: constraints.biggest.shortestSide,
                  child: Transform.rotate(
                    angle: -pi / 4,
                    child: FittedBox(
                      child: Text(watermark!),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
