import 'package:flutter/material.dart';

import '../../public_code.dart';

class ScrollableListDemoPage extends StatefulWidget {
  const ScrollableListDemoPage({Key? key}) : super(key: key);

  @override
  State<ScrollableListDemoPage> createState() => _ScrollableListDemoPageState();
}

class _ScrollableListDemoPageState extends State<ScrollableListDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("可滚动列表"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future.delayed(const Duration(seconds: 3));
        },
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Dismissible(
              movementDuration: const Duration(seconds: 1),
              confirmDismiss: (direction) {
                return showDialog<bool>(
                  context: context,
                  barrierDismissible: false, // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('确定删除?'),
                      content: const Text('确定删除当前项目?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('取消'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop(false); // Dismiss alert dialog
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                          child: const Text('删除'),
                          onPressed: () {
                            Navigator.of(dialogContext).pop(true); // Dismiss alert dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              background: Container(color: Colors.blue),
              secondaryBackground: Container(color: Colors.green),
              onDismissed: (direction) {
                logger.d("Svran: Flutter -> $direction");
              },
              key: UniqueKey(),
              child: ListTile(title: Text('This is item in ListView _ $index')),
            );
          },
        ),
      ),
    );
  }
}
