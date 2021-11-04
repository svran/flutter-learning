import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TweenAnimBuilderDemoPage extends StatefulWidget {
  const TweenAnimBuilderDemoPage({Key? key}) : super(key: key);

  @override
  State<TweenAnimBuilderDemoPage> createState() => _TweenAnimBuilderDemoPageState();
}

class _TweenAnimBuilderDemoPageState extends State<TweenAnimBuilderDemoPage> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("补间动画"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _big = !_big;
          });
        },
      ),
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 1),
          tween: Tween(begin: 72.0, end: _big ? 172.0 : 72.0),
          builder: (context, value, child) {
            return Container(
              width: 300,
              height: 300,
              color: Colors.blue,
              child: Center(
                // child: Transform.scale(
                // scale: value,
                child: Text(
                  'Hi',
                  style: TextStyle(
                    fontSize: value,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
