import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home_app_bar.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home_content.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home_drawer.dart';

class SvranHomeScreen extends StatelessWidget {
  const SvranHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SvranHomeAppBar(context),
      body: const Center(
        child: SvranHomeContent(),
      ),
    );
  }
}
