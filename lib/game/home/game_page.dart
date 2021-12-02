import 'package:flutter/material.dart';
import 'package:svran_flutter_study/boom/widget/boom_widget.dart';
import 'package:svran_flutter_study/game/play/play_game.dart';

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
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(SvranPlayPage.routeName);
                },
                icon: Icon(Icons.catching_pokemon),
                label: Text('开始'),
              ),
              SizedBox(height: 5.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(SvranPlayPage.routeName);
                },
                icon: Icon(Icons.settings),
                label: Text('设置'),
              ),
              SizedBox(height: 5.0),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(SvranPlayPage.routeName);
                },
                icon: Icon(Icons.info),
                label: Text('关于'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
