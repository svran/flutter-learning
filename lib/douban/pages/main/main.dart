import 'package:flutter/material.dart';
import 'package:svran_flutter_study/douban/pages/main/initialize_items.dart';

class SvranMainPage extends StatefulWidget {
  const SvranMainPage({Key? key}) : super(key: key);

  @override
  _SvranMainPageState createState() => _SvranMainPageState();
}

class _SvranMainPageState extends State<SvranMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: items,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
