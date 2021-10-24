import 'package:flutter/material.dart';
import 'package:svran_flutter_study/study/animation/hero2_image_detail_page.dart';

import 'hero_2_page.dart';

class HeroAnimDemoPage extends StatefulWidget {
  const HeroAnimDemoPage({Key? key}) : super(key: key);

  @override
  State<HeroAnimDemoPage> createState() => _HeroAnimDemoPageState();
}

class _HeroAnimDemoPageState extends State<HeroAnimDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero 动画"),
      ),
      body: Container(
        color: Colors.red.withAlpha(0x30),
        child: Center(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 16 / 9,
            ),
            children: List.generate(20, (index) {
              final image = "https://picsum.photos/300/200?random=$index";
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      // builder: (context) => const SvranModalPage(),
                      fullscreenDialog: true,
                      pageBuilder:
                          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                        // return const SvranModalPage();
                        return FadeTransition(
                          opacity: animation,
                          child: SvranImageDetailPage(url: image),
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: image,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const SvranModalPage(),
          //     fullscreenDialog: true,
          //   ),
          // );

          // 页面跳转动画
          // Navigator.of(context).push(
          //   PageRouteBuilder(
          //     // builder: (context) => const SvranModalPage(),
          //     transitionDuration: const Duration(seconds: 1),
          //     fullscreenDialog: true,
          //     pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          //       // return const SvranModalPage();
          //       return FadeTransition(
          //         opacity: animation,
          //         child: const SvranModalPage(),
          //       );
          //     },
          //   ),
          // );

          Navigator.of(context).push(
            PageRouteBuilder(
              // builder: (context) => const SvranModalPage(),
              transitionDuration: const Duration(seconds: 1),
              fullscreenDialog: true,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                // return const SvranModalPage();
                return FadeTransition(
                  opacity: animation,
                  child: const SvranModalPage(),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.pool),
      ),
    );
  }
}
