import 'package:flutter/material.dart';
import 'package:svran_flutter_study/boom/widget/boom_widget.dart';

class SvranGameAwWxPage extends StatefulWidget {
  const SvranGameAwWxPage({Key? key}) : super(key: key);

  @override
  State<SvranGameAwWxPage> createState() => _SvranGameAwWxPageState();
}

class _SvranGameAwWxPageState extends State<SvranGameAwWxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("爱玩武侠?"),
      ),
      body: SvranClickBoomWidget(
        child: Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.catching_pokemon),
                label: Text('开始'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
