import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home_content.dart';
import 'package:svran_flutter_study/douban/main.dart';

class SvranHomeScreen extends StatelessWidget {
  const SvranHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('没事光长'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: const Center(
        child: SvranHomeContent(),
      ),
    );
  }
}
