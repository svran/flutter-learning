import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/boom/widget/boom_widget.dart';
import 'package:svran_flutter_study/game/providers/model/game_card.dart';
import 'package:svran_flutter_study/game/providers/view_model/game_player_view_model.dart';
import 'package:svran_flutter_study/game/providers/view_model/game_setting_view_model.dart';
import 'package:svran_flutter_study/game/widget/blood_bar.dart';
import 'package:svran_flutter_study/game/widget/game_card.dart';

class SvranPlayPage extends StatefulWidget {
  static const String routeName = "/SvranPlayPage";

  const SvranPlayPage({Key? key}) : super(key: key);

  @override
  State<SvranPlayPage> createState() => _SvranPlayPageState();
}

class _SvranPlayPageState extends State<SvranPlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("爱玩武侠?"),
      ),
      body: SvranClickBoomWidget(
        child: Column(
          children: [
            Expanded(flex: 3, child: Container(child: _buildTop())),
            Divider(color: Colors.grey),
            Expanded(flex: 2, child: Container(child: _buildCenter())),
            Divider(color: Colors.grey),
            Expanded(flex: 4, child: Container(child: _buildBottom()))
          ],
        ),
      ),
    );
  }

  _buildTop() {
    return Column(
      children: [
        Expanded(child: Text('fjla')),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer2<SvranGamePlayerViewModel, SvranGameSettingViewModel>(
            builder: (context, player, setting, child) {
              return SvranGameBloodBar(
                duration: Duration(milliseconds: 300),
                max: setting.gameSetting.blood,
                current: player.gamePlayer.player1Blood,
              );
            },
          ),
        ),
        Card(),
      ],
    );
  }

  _buildCenter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Draggable(
          feedback: SvranGameCardWidget(
            card: SvranGameCard("测试卡片", "此卡异常嚣张\n甚至能搞出新花样", "", 0, 10, 15, 5, SvranGameCardType.kill),
          ),
          child: SvranGameCardWidget(
            card: SvranGameCard("测试卡片", "此卡异常嚣张\n甚至能搞出新花样", "", 0, 10, 15, 5, SvranGameCardType.kill),
          ),
        ),
        Card(
          color: Colors.blue,
          child: Text('出卡', style: TextStyle(fontSize: 20, color: Colors.white)),
          elevation: 3,
        ),
        Selector2<SvranGamePlayerViewModel, SvranGameSettingViewModel, SvranGamePlayerViewModel>(
          selector: (p0, p1, p2) => p1,
          shouldRebuild: (previous, next) => false,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      value.setBlood(100);
                    },
                    child: Text('重置')),
                ElevatedButton(
                    onPressed: () {
                      value.changeBlood(10);
                    },
                    child: Text('增加')),
                ElevatedButton(
                    onPressed: () {
                      value.changeBlood(-10);
                    },
                    child: Text('减少')),
                ElevatedButton(
                    onPressed: () {
                      value.changePlayer();
                    },
                    child: Text('切换')),
              ],
            );
          },
        ),
      ],
    );
  }

  _buildBottom() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer2<SvranGamePlayerViewModel, SvranGameSettingViewModel>(
            builder: (context, player, setting, child) {
              return SvranGameBloodBar(
                duration: Duration(milliseconds: 300),
                max: setting.gameSetting.blood,
                current: player.gamePlayer.player2Blood,
              );
            },
          ),
        ),
        Expanded(child: Text('fjla')),
        Card(),
      ],
    );
  }
}
