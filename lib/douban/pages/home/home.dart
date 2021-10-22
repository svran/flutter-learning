import 'package:flutter/material.dart';
import 'package:svran_flutter_study/douban/pages/home/home_content.dart';

class SvranHomePage extends StatefulWidget {
  const SvranHomePage({Key? key}) : super(key: key);

  @override
  _SvranHomePageState createState() => _SvranHomePageState();
}

class _SvranHomePageState extends State<SvranHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: SvranHomeContent(),
    );
  }
}
