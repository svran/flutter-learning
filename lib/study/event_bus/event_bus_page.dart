import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

// event_bus:
// 创建全局EventBus对象
//
final eventBus = EventBus();

class EventBusDemoPage extends StatefulWidget {
  const EventBusDemoPage({Key? key}) : super(key: key);

  @override
  State<EventBusDemoPage> createState() => _EventBusDemoPageState();
}

class _EventBusDemoPageState extends State<EventBusDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("事件总线"),
        ),
        body: Container(
          color: Colors.red.withAlpha(0x30),
          child: Center(
            child: Column(
              children: const <Widget>[
                SvranButton(),
                SvranText(),
              ],
            ),
          ),
        ));
  }
}

class SvranButton extends StatelessWidget {
  const SvranButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          eventBus.fire(UserInfoEventBus("Svran", 21));
        },
        icon: const Icon(Icons.add));
  }
}

class UserInfoEventBus {
  String name = "";
  int age = 0;

  UserInfoEventBus(this.name, this.age);
}

class SvranText extends StatefulWidget {
  const SvranText({Key? key}) : super(key: key);

  @override
  _SvranTextState createState() => _SvranTextState();
}

class _SvranTextState extends State<SvranText> {
  String _txt = "---";

  @override
  void initState() {
    super.initState();
    eventBus.on<UserInfoEventBus>().listen((event) {
      setState(() {
        _txt = "${event.age} ${event.name}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _txt,
      style: const TextStyle(fontSize: 30, color: Colors.red),
    );
  }
}
