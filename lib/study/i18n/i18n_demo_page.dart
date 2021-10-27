import 'package:flutter/material.dart';
import 'package:svran_flutter_study/generated/l10n.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranI18nDemoPage extends StatefulWidget {
  static const String routeName = "/SvranI18nDemoPage";

  const SvranI18nDemoPage({Key? key}) : super(key: key);

  @override
  State<SvranI18nDemoPage> createState() => _SvranI18nDemoPageState();
}

class _SvranI18nDemoPageState extends State<SvranI18nDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("国际化实例"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            // Text(SvranI18nDemoLocalizations.of(context).title, style: Theme.of(context).textTheme.headline5),
            // Text(SvranI18nDemoLocalizations.of(context).hello, style: Theme.of(context).textTheme.headline5),
            // Text(SvranI18nDemoLocalizations.of(context).pickTime, style: Theme.of(context).textTheme.headline5),
            Text(S.of(context).title, style: Theme.of(context).textTheme.headline5),
            Text(S.of(context).hello, style: Theme.of(context).textTheme.headline5),
            Text(S.of(context).pickTime, style: Theme.of(context).textTheme.headline5),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2099),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                "另外还有一种方案,也是最佳方案. 使用arb语言包的方式.\n "
                "1. 去IDE插件市场,下载一个国际化辅助插件 Flutter Intl .\n"
                "2. IDE的功能菜单选择 Tools -> Flutter Intl -> Initialize for the project 等待执行完成. 它会生成 I10n 和 generated 文件夹 以及其他相应文件. \n"
                "3. 在 I10n 相应语言文件下,编写对应的键值对即可. 如果需要新增其他的语言, 在之前菜单下边有个 Add Locale ,输入对应语言代码即可.\n"
                "4. 然后就是基础配置 supportedLocales:S.delegate.supportedLocales, localizationsDelegates:S.delegate 属性.\n"
                "5. 需要使用国际化的时候,可以直接 S.of(context).xxx 即可.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 10.px),
          ],
        ),
      ),
    );
  }
}
