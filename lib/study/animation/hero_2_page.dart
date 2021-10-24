import 'package:flutter/material.dart';

class SvranModalPage extends StatefulWidget {
  const SvranModalPage({Key? key}) : super(key: key);

  @override
  State<SvranModalPage> createState() => _SvranModalPageState();
}

class _SvranModalPageState extends State<SvranModalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("第二个页面"),
        ),
        body: Container(
          color: Colors.blue.withAlpha(0x30),
          child: const Center(
            child: Text('Hero 动画'),
          ),
        ));
  }
}
