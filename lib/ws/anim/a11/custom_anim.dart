import 'package:flutter/material.dart';

class SvranCustomAnimDemoPage extends StatefulWidget {
  const SvranCustomAnimDemoPage({Key? key}) : super(key: key);

  @override
  State<SvranCustomAnimDemoPage> createState() => _SvranCustomAnimDemoPageState();
}

class _SvranCustomAnimDemoPageState extends State<SvranCustomAnimDemoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation oa = Tween(begin: 0.5, end: 0.8).animate(_controller);
    final Animation ha = Tween(begin: 200.0, end: 300.0).animate(_controller);
    final Animation wa =
        Tween(begin: 200.0, end: 300.0).chain(CurveTween(curve: Curves.bounceOut)).animate(_controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义动画"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (_controller.isAnimating) {
            _controller.stop();
          } else {
            _controller.repeat(reverse: true);
          }
        },
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: oa.value,
              child: Container(
                width: wa.value,
                height: ha.value,
                color: Colors.blue,
                child: child,
              ),
            );
          },
          child: Center(
            child: Text('Hi', style: TextStyle(fontSize: 72)),
          ),
        ),
      ),
    );
  }
}
