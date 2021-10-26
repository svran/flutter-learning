import 'package:flutter/material.dart';

class SvranContacts extends StatelessWidget {
  final List<String> _names;

  const SvranContacts(this._names, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mode = "默认!";
    assert(() {
      mode = "debug模式";
      return true;
    }()); // (){}() 函数后,添加一对小括号,立即执行函数.
    _names.add("追加(运行模式): $mode"); // 利用只有在debug模式才执行的assert监听运行模式.
    // 最佳运行模式判断方案: 使用常量 kDebugMode
    return Scaffold(
      body: ListView(
        children: _names
            .map((e) => ListTile(
                  leading: const Icon(Icons.people),
                  title: Text(e),
                ))
            .toList(),
      ),
    );
  }
}
