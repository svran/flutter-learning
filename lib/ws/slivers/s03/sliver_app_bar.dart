import 'package:flutter/material.dart';

class SliverAppBarDemoPage extends StatefulWidget {
  const SliverAppBarDemoPage({Key? key}) : super(key: key);

  @override
  State<SliverAppBarDemoPage> createState() => _SliverAppBarDemoPageState();
}

class _SliverAppBarDemoPageState extends State<SliverAppBarDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("SliverAppBar"),
      // ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            // title: Text('SliverAppBar'),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
              title: Text('SliverAppBar'),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
                StretchMode.zoomBackground,
              ],
              // collapseMode: CollapseMode.pin,
            ),
            floating: true,
            // snap: true,
            // pinned: true,
          ),
          const SliverToBoxAdapter(child: Placeholder()),
          SliverList(
            delegate: SliverChildListDelegate([
              const FlutterLogo(),
              const FlutterLogo(size: 200),
              const FlutterLogo(size: 200),
              const FlutterLogo(),
              const FlutterLogo(),
            ]),
          ),
        ],
      ),
    );
  }
}
