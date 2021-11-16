import 'package:flutter/material.dart';
import 'package:svran_flutter_study/extensions/relative_rect.dart';

class ActUnpopularWidgetDemoPage extends StatefulWidget {
  const ActUnpopularWidgetDemoPage({Key? key}) : super(key: key);

  @override
  State<ActUnpopularWidgetDemoPage> createState() => _ActUnpopularWidgetDemoPageState();
}

class _ActUnpopularWidgetDemoPageState extends State<ActUnpopularWidgetDemoPage> {
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("冷门Flutter组件"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.5,
              child: GestureDetector(
                onSecondaryTap: () {
                  showMenu(
                    context: context,
                    position: RelativeRectExt.fromOffsetExt(offset),
                    items: [
                      PopupMenuItem(
                        child: Text('搞事情'),
                      ),
                      PopupMenuItem(
                        child: Text('不搞事情'),
                        enabled: false,
                        mouseCursor: SystemMouseCursors.forbidden,
                      ),
                    ],
                  );
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.precise,
                  onHover: (event) {
                    setState(() {
                      offset = event.position;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    color: Colors.red,
                    child: Text('当前控件: FractionallySizedBox'
                        '\nwidthFactor: 0.5'
                        '\n宽度占用父组件的百分之50\n'
                        '鼠标位置: $offset'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
