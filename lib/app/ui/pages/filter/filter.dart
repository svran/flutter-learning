import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/filter/filter_content.dart';

class SvranFilterScreen extends StatelessWidget {
  static const routeName = "/SvranFilterScreen";

  const SvranFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('没事过滤一下吧'),
      ),
      body: const SvranFilterContent(),
    );
  }
}
