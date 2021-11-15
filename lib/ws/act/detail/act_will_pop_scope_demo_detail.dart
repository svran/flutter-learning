import 'package:flutter/material.dart';

class WillPopScopeDetailDemoPage extends StatefulWidget {
  const WillPopScopeDetailDemoPage({Key? key}) : super(key: key);

  @override
  State<WillPopScopeDetailDemoPage> createState() => _WillPopScopeDetailDemoPageState();
}

class _WillPopScopeDetailDemoPageState extends State<WillPopScopeDetailDemoPage> {
  bool isLock = false;

  // Future<bool> preventExit() async => false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("解决 WillPopScope 与 iOS 手势冲突问题"),
      ),
      body: WillPopScope(
        onWillPop: isLock
            ? () async {
                return false;
              }
            : null,
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                isLock = !isLock;
                // if (isLock) {
                //   ModalRoute.of(context)?.addScopedWillPopCallback(preventExit);
                // } else {
                //   ModalRoute.of(context)?.removeScopedWillPopCallback(preventExit);
                // }
              });
            },
            icon: Icon(isLock ? Icons.lock : Icons.lock_open),
            label: Text(isLock ? 'Lock' : 'unLock'),
          ),
        ),
      ),
    );
  }
}
