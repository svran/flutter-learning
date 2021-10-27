import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SvranMethodChannel extends StatefulWidget {
  const SvranMethodChannel({Key? key}) : super(key: key);

  @override
  State<SvranMethodChannel> createState() => _SvranMethodChannelState();
}

class _SvranMethodChannelState extends State<SvranMethodChannel> {
  // static const platform = MethodChannel("域名/功能");
  static const platform = MethodChannel("svran.air/battery");
  var _level = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("原生插件"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.face_unlock_outlined),
              label: const Text('获取剩余电量'),
              onPressed: getBatteryInfo,
            ),
            Text('剩余电量: ${-1 == _level ? "未获取" : _level}'),
          ],
        ),
      ),
    );
  }

  Future<void> getBatteryInfo() async {
    final result = await platform.invokeMethod("getBatteryInfo");
    setState(() {
      _level = result;
    });
  }
}
