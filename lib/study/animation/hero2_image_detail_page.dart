import 'package:flutter/material.dart';

class SvranImageDetailPage extends StatefulWidget {
  final String url;

  const SvranImageDetailPage({Key? key, this.url = ""}) : super(key: key);

  @override
  State<SvranImageDetailPage> createState() => _SvranImageDetailPageState();
}

class _SvranImageDetailPageState extends State<SvranImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Hero(tag: widget.url, child: Image.network(widget.url)),
          ),
        ));
  }
}
