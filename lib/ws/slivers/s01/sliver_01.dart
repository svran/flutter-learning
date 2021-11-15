import 'package:flutter/material.dart';

class Sliver01DemoPage extends StatefulWidget {
  const Sliver01DemoPage({Key? key}) : super(key: key);

  @override
  State<Sliver01DemoPage> createState() => _Sliver01DemoPageState();
}

class _Sliver01DemoPageState extends State<Sliver01DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("滚动视窗 CustomScrollView"),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: FlutterLogo(size: 200)),
          const SliverToBoxAdapter(child: Text('text', style: TextStyle(fontSize: 25))),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 200,
                  color: Colors.primaries[index % 10],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
