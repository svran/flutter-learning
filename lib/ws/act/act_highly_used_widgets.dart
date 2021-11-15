import 'package:flutter/material.dart';

class HighlyUsedWidgetDemoPage extends StatefulWidget {
  const HighlyUsedWidgetDemoPage({Key? key}) : super(key: key);

  @override
  State<HighlyUsedWidgetDemoPage> createState() => _HighlyUsedWidgetDemoPageState();
}

class _HighlyUsedWidgetDemoPageState extends State<HighlyUsedWidgetDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("使用率高的一些组件"),
      ),
      body: Center(
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('根据内容,会自动调整大小的组件 FittedBox. BoxFit.scaleDown 可以限制 不会自动放大,但是会自动缩小.'),
            ),
            SafeArea(
              minimum: EdgeInsets.all(8.0),
              child: Text('SafeArea 用于避让一些异形屏的缺陷区域, minimum 最小留白'),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Text('LayoutBuilder 能得到上级的尺寸约束. \n获取数据: \n$constraints');
              },
            ),
            OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return Text('类似LayoutBuilder, 直接获取屏幕方向. $orientation');
              },
            ),
            DefaultTextStyle.merge(
              style: TextStyle(color: Colors.blue),
              child: Text('DefaultTextStyle 可以与下级 textStyle 合并.'
                  '\nDefaultTextStyle 还提供了一个 AnimatedDefaultTextStyle 隐式动画组件.'
                  '\nDefaultTextStyle 还可以用DefaultTextStyle.merge 把上级的style 合并过来'),
            ),
            // InteractiveViewer(
            //   constrained: false,
            //   child: SizedBox(
            //     height: 300,
            //     width: 800,
            //     child: Row(
            //       children: [
            //         Text('InteractiveViewer '),
            //         Text('InteractiveViewer '),
            //         Text('InteractiveViewer '),
            //         Text('InteractiveViewer '),
            //         Text('InteractiveViewer '),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
