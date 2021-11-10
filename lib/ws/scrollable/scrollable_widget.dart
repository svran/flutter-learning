import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
            child: PageView(
              children: [],
            ),
          ),
          SizedBox(
            height: 300,
            child: ListWheelScrollView(
              overAndUnderCenterOpacity: 0.5,
              magnification: 1.2,
              itemExtent: 80,
              // offAxisFraction: -1.2,
              // diameterRatio: 0.7,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (value) => showToast("选择了 $value"),
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
        ],
      ),
    );
  }
}
