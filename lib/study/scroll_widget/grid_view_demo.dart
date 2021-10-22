import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

// 瀑布流可用 https://pub.dev/packages/flutter_staggered_grid_view

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("滚动控件学习"),
        ),
        body: Container(
          color: Colors.red.withAlpha(0x30),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemBuilder: (context, index) {
                return Container(color: randomColor());
              }),
        ));
  }
}

class GridDemo2Widget extends StatelessWidget {
  const GridDemo2Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      children: List.generate(100, (index) {
        return Container(color: randomColor());
      }),
    );
  }
}

class GridDemoWidget extends StatelessWidget {
  const GridDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        children: List.generate(100, (index) {
          return Container(color: randomColor());
        }),
      ),
    );
  }
}
