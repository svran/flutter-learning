import 'package:flutter/material.dart';

class Slivers04DemoPage extends StatefulWidget {
  const Slivers04DemoPage({Key? key}) : super(key: key);

  @override
  State<Slivers04DemoPage> createState() => _Slivers04DemoPageState();
}

class _Slivers04DemoPageState extends State<Slivers04DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("更多的Sliver组件"),
      // ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('更多的Sliver组件'),
          ),
          SliverPadding(
            sliver: SliverIgnorePointer(
              ignoring: false,
              sliver: SliverAnimatedOpacity(
                opacity: 0.7,
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const FlutterLogo(size: 100),
                  ),
                ),
                duration: const Duration(seconds: 1),
              ),
            ),
            padding: const EdgeInsets.all(15.0),
          ),
          SliverGrid(
            delegate: SliverChildListDelegate([
              const Icon(Icons.add),
              const Icon(Icons.add),
              const Icon(Icons.add),
              const Icon(Icons.add),
            ]),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(thickness: 4.0, color: Colors.red),
          ),
          // SliverFillRemaining(
          //   child: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return const SliverToBoxAdapter(
                child: FlutterLogo(),
              );
            },
          ),
        ],
      ),
    );
  }
}
