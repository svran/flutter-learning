import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/filter/filter.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranHomeDrawer extends StatelessWidget {
  const SvranHomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.px,
      child: Drawer(
        child: Column(
          children: [
            buildHeaderView(context),
            buildListTile(context, const Icon(Icons.restaurant), "进餐", () {
              Navigator.pop(context);
            }),
            buildListTile(context, const Icon(Icons.settings), "过滤", () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, SvranFilterScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }

  buildHeaderView(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.px),
      color: Colors.orange,
      width: double.infinity,
      height: 100.px,
      alignment: const Alignment(0, 0.5),
      child: Text('开始动手', style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  buildListTile(BuildContext context, Widget icon, String text, GestureTapCallback handler) {
    return ListTile(
      onTap: handler,
      leading: icon,
      title: Text(text, style: Theme.of(context).textTheme.headline5),
    );
  }
}
