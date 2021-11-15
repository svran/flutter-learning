import 'package:flutter/material.dart';

class Sliver02DemoPage extends StatefulWidget {
  const Sliver02DemoPage({Key? key}) : super(key: key);

  @override
  State<Sliver02DemoPage> createState() => _Sliver02DemoPageState();
}

class _Sliver02DemoPageState extends State<Sliver02DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("其他Sliver组件"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillViewport(
            delegate: SliverChildListDelegate([
              Container(color: Colors.red),
              Container(color: Colors.blue),
              Container(color: Colors.green),
            ]),
          ),
          SliverPrototypeExtentList(
              delegate: SliverChildListDelegate([
                const FlutterLogo(),
                const FlutterLogo(size: 100),
                const FlutterLogo(),
              ]),
              prototypeItem: const FlutterLogo(size: 48)),
          SliverFixedExtentList(
              itemExtent: 100,
              delegate: SliverChildListDelegate([
                const FlutterLogo(),
                const FlutterLogo(size: 100),
                const FlutterLogo(),
              ])),
          SliverList(
              delegate: SliverChildListDelegate([
            const FlutterLogo(),
            const FlutterLogo(size: 100),
            const FlutterLogo(),
          ])),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    height: 200,
                    color: Colors.primaries[index % 10],
                  );
                },
                childCount: 9,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3)),
        ],
      ),
    );
  }
}
