import 'package:flutter/material.dart';
import 'package:svran_flutter_study/douban/model/home_model.dart';
import 'package:svran_flutter_study/douban/service/home_request.dart';

class SvranHomeContent extends StatefulWidget {
  const SvranHomeContent({Key? key}) : super(key: key);

  @override
  _SvranHomeContentState createState() => _SvranHomeContentState();
}

class _SvranHomeContentState extends State<SvranHomeContent> {
  final List<DataItem?> movies = [];

  @override
  void initState() {
    super.initState();
    HomeRequest.requestMovieList(1, 294).then((value) {
      setState(() {
        if (value != null) {
          movies.addAll(value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index]?.title ?? ""),
        );
      },
    );
  }
}
