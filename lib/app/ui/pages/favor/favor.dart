import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/favor/favor_content.dart';

class SvranFavorScreen extends StatelessWidget {
  const SvranFavorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收藏'),
      ),
      body: const SvranFavorContent(),
    );
  }
}
