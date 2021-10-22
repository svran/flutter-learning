import 'package:flutter/material.dart';

class SvranSubjectContent extends StatefulWidget {
  const SvranSubjectContent({Key? key}) : super(key: key);

  @override
  _SvranSubjectContentState createState() => _SvranSubjectContentState();
}

class _SvranSubjectContentState extends State<SvranSubjectContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('subject $index'),
        );
      },
    );
  }
}
