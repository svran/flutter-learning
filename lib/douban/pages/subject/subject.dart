import 'package:flutter/material.dart';
import 'package:svran_flutter_study/douban/pages/subject/subject_content.dart';

class SvranSubjectPage extends StatefulWidget {
  const SvranSubjectPage({Key? key}) : super(key: key);

  @override
  _SvranSubjectPageState createState() => _SvranSubjectPageState();
}

class _SvranSubjectPageState extends State<SvranSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('subject'),
      ),
      body: SvranSubjectContent(),
    );
  }
}
