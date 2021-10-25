import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home_drawer.dart';

import 'init_items.dart';

class SvranMainScreen extends StatefulWidget {
  static const String routeName = "/";

  const SvranMainScreen({Key? key}) : super(key: key);

  @override
  State<SvranMainScreen> createState() => _SvranMainScreenState();
}

class _SvranMainScreenState extends State<SvranMainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: items,
      ),
      drawer: const SvranHomeDrawer(),
    );
  }
}
