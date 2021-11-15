import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ws/act/detail/act_will_pop_scope_demo_detail.dart';

class AddWillPopScopeDemoPage extends StatefulWidget {
  const AddWillPopScopeDemoPage({Key? key}) : super(key: key);

  @override
  State<AddWillPopScopeDemoPage> createState() => _AddWillPopScopeDemoPageState();
}

class _AddWillPopScopeDemoPageState extends State<AddWillPopScopeDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WillPopScopeDetailDemoPage()));
          },
          icon: const Icon(Icons.arrow_right),
          label: const Text('下一页'),
        ),
      ),
    );
  }
}
