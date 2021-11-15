import 'package:flutter/material.dart';

class ActHollowedTextDemoPage extends StatefulWidget {
  const ActHollowedTextDemoPage({Key? key}) : super(key: key);

  @override
  State<ActHollowedTextDemoPage> createState() => _ActHollowedTextDemoPageState();
}

class _ActHollowedTextDemoPageState extends State<ActHollowedTextDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("文字镂空效果"),
      ),
      body: const Center(
        child: HollowedText(
          text: "HollowedText",
          size: 70,
          color: Colors.red,
        ),
      ),
    );
  }
}

class HollowedText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const HollowedText({Key? key, required this.text, required this.size, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
