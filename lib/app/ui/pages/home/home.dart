import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home_content.dart';

class SvranHomeScreen extends StatelessWidget {
  const SvranHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('没事光长'),
      ),
      body: Center(
        child: SvranHomeContent(),
      ),
    );
  }
}
