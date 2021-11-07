import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AminPrincipleDemoPage extends StatefulWidget {
  const AminPrincipleDemoPage({Key? key}) : super(key: key);

  @override
  State<AminPrincipleDemoPage> createState() => _AminPrincipleDemoPageState();
}

class _AminPrincipleDemoPageState extends State<AminPrincipleDemoPage> {
  double _height = 300;
  late Ticker ticker;

  @override
  void initState() {
    ticker = Ticker((elapsed) {
      setState(() {
        _height--;
        if (_height <= 0) _height = 300;
      });
    });
    ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    ticker.stop();
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("动画背后的机制和原理"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: _height,
          color: Colors.blue,
        ),
      ),
    );
  }
}
