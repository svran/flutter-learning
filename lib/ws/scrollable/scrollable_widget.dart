import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';

class ScrollableWidgetDemoPage extends StatefulWidget {
  const ScrollableWidgetDemoPage({Key? key}) : super(key: key);

  @override
  State<ScrollableWidgetDemoPage> createState() => _ScrollableWidgetDemoPageState();
}

class _ScrollableWidgetDemoPageState extends State<ScrollableWidgetDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("其他可滚动控件"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Row(
              children: [
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(color: Colors.red),
                      Container(color: Colors.blue),
                    ],
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    children: List.generate(20, (index) => Text('text _ $index', key: ValueKey(index))),
                    onReorder: (oldIndex, newIndex) {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: Row(
              children: [
                Expanded(
                  child: ListWheelScrollView(
                    overAndUnderCenterOpacity: 0.5,
                    magnification: 1.2,
                    itemExtent: 80,
                    // offAxisFraction: -1.2,
                    // diameterRatio: 0.7,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (value) => svranToast("选择了 $value"),
                    children: List.generate(
                      10,
                      (index) => Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: Text('wheel $index'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  // SingleChildScrollView 用于平常界面基本不需要滚动,但是有很小的可能会需要滚动的场景
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        FlutterLogo(size: 300),
                        FlutterLogo(size: 300),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
