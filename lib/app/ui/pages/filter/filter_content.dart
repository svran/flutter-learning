import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/core/view_model/filter_view_model.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranFilterContent extends StatelessWidget {
  const SvranFilterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildYourChoice(context),
        buildChoiceSelect(),
      ],
    );
  }

  buildYourChoice(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.px),
      alignment: Alignment.center,
      child: Text(
        '展示你的选择',
        style: Theme.of(context).textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  buildChoiceSelect() {
    return Expanded(
      child: Consumer<SvranFilterViewModel>(
        builder: (context, filterVm, child) {
          return ListView(
            children: [
              buildListTile("无谷蛋白", "无谷蛋白", filterVm.isGlutenFree, (value) => filterVm.isGlutenFree = value),
              buildListTile("不含乳糖", "不含乳糖", filterVm.isLactoseFree, (value) => filterVm.isLactoseFree = value),
              buildListTile("素食主义", "素食主义", filterVm.isVegetarian, (value) => filterVm.isVegetarian = value),
              buildListTile("严格素食主义", "严格素食主义", filterVm.isVegan, (value) => filterVm.isVegan = value),
            ],
          );
        },
      ),
    );
  }

  buildListTile(String title, String subTitle, bool value, ValueChanged<bool> onChange) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: Switch(
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
