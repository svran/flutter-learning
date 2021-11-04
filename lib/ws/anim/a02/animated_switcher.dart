import 'package:flutter/material.dart';

class AnimatedSwitcherDemoPage extends StatefulWidget {
  const AnimatedSwitcherDemoPage({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitcherDemoPage> createState() => _AnimatedSwitcherDemoPageState();
}

class _AnimatedSwitcherDemoPageState extends State<AnimatedSwitcherDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedSwitcherDemo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            //
          });
        },
      ),
      body: Center(
        child: AnimatedContainer(
          color: Colors.blueAccent,
          width: 300,
          height: 300,
          duration: const Duration(milliseconds: 500),
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  // opacity: animation,
                  scale: animation,
                  child: child,
                ),
              );
            },
            duration: Duration(seconds: 1),
            child: Text('text'),
            // child: Icon(Icons.pets),
          ),
        ),
      ),
    );
  }
}
