import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/study/router/about_page.dart';
import 'package:svran_flutter_study/study/router/detail_page.dart';

class RouterDemoPage extends StatefulWidget {
  const RouterDemoPage({Key? key}) : super(key: key);

  @override
  State<RouterDemoPage> createState() => _RouterDemoPageState();
}

class _RouterDemoPageState extends State<RouterDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("路由"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              IconButton(
                  tooltip: "普通路由跳转",
                  onPressed: () {
                    var f = Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const RouterDetailPage(message: "传递参数");
                      },
                    ));
                    f.then((value) {
                      if (value != null) svranToast("$value");
                    });
                  },
                  icon: const Icon(Icons.publish_sharp)),
              IconButton(
                tooltip: "命名路由跳转",
                onPressed: () {
                  var t = Navigator.of(context).pushNamed(
                    RouterAboutPage.routeName,
                    arguments: "命名路由跳转参数",
                  );
                  t.then((value) {
                    if (value != null) showToast("$value");
                  });
                },
                icon: const Icon(Icons.drive_file_rename_outline),
              ),
              IconButton(
                  tooltip: "命名路由跳转 带参数",
                  onPressed: () {
                    var t = Navigator.of(context).pushNamed(
                      RouterAboutPage.routeName,
                      arguments: "命名路由跳转参数2",
                    );
                    t.then((value) {
                      if (value != null) showToast("$value");
                    });
                  },
                  icon: const Icon(Icons.event)),
              IconButton(
                  tooltip: "路由跳转错误",
                  onPressed: () {
                    var t = Navigator.of(context).pushNamed(
                      "xxx",
                      arguments: "命名路由跳转参数2",
                    );
                    t.then((value) {
                      if (value != null) showToast("$value");
                    });
                  },
                  icon: const Icon(Icons.event)),
            ],
          ),
        ));
  }
}
