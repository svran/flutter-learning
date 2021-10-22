import 'package:flutter/material.dart';
import 'package:svran_flutter_study/public_code.dart';

class CustomSliverViewPage extends StatefulWidget {
  const CustomSliverViewPage({Key? key}) : super(key: key);

  @override
  State<CustomSliverViewPage> createState() => _CustomSliverViewPageState();
}

class _CustomSliverViewPageState extends State<CustomSliverViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("自定义滚动控件"),
        // ),
        body: Container(
      color: Colors.red.withAlpha(0x30),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Hello Word'),
              background: Image.asset(
                "assets/img/img_clannad_bg.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(color: randomColor());
              },
              childCount: 10,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: const Icon(Icons.people),
                title: Text('联系人: $index'),
              );
            },
            childCount: 20,
          ))
        ],
      ),
    ));
  }
}

class CustomScrollViewDemoWidget extends StatelessWidget {
  const CustomScrollViewDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(color: randomColor());
                },
                childCount: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
