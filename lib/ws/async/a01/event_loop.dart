import 'package:flutter/material.dart';

class EventLoopDemoPage extends StatefulWidget {
  const EventLoopDemoPage({Key? key}) : super(key: key);

  @override
  State<EventLoopDemoPage> createState() => _EventLoopDemoPageState();
}

class _EventLoopDemoPageState extends State<EventLoopDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("事件循环 Event Loop"),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.black12,
              child: Text('直接运行\nFuture.sync()\nFuture.value()\n _.then()'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(5.0),
              color: Colors.black26,
              child: Text('Microtask\nscheduleMicrotast()\nFuture.microtask()\n _completed.then()'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(5.0),
              color: Colors.black38,
              child: Text('Event\nFuture()\nFuture.delayed()'),
            ),
          ],
        ),
      ),
    );
  }
}
