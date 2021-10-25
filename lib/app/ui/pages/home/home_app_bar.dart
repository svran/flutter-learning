import 'package:flutter/material.dart';

import '../../../../main.dart';

class SvranHomeAppBar extends AppBar {
  SvranHomeAppBar(BuildContext context, {Key? key})
      : super(
          key: key,
          // 使用这个 Builder 拿到当前Widget的context,再打开抽屉
          // leading: Builder(builder: (context) {
          //   return IconButton(
          //     icon: const Icon(Icons.settings, color: Colors.white),
          //     onPressed: () {
          //       Scaffold.of(context).openDrawer();
          //     },
          //   );
          // }),
          leading: IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // 这里直接拿到的是
            }, //                                //   Widget build(BuildContext context) 里边的context的Scaffold.
          ),
          title: const Text('没事光长'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
              },
              icon: const Icon(Icons.menu),
            ),
          ],
        );
}
