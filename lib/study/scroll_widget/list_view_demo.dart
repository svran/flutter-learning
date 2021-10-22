import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("滚动控件学习"),
        ),
        body: Container(
          color: Colors.red.withAlpha(0x30),
          child: ListView.separated(
            padding: const EdgeInsets.all(5),
            itemCount: 50,
            itemBuilder: (context, index) {
              return Text(
                'Hello Word ! $index \n hello !',
                style: const TextStyle(fontSize: 20),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 4, color: Colors.red, thickness: 2, indent: 5, endIndent: 5);
            },
          ),
        ));
  }
}

class ListViewBuilderDemoWidget extends StatelessWidget {
  const ListViewBuilderDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemExtent: 30,
      itemBuilder: (context, index) {
        return Text(
          'Hello Word ! $index',
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }
}

class ListDemoWidget extends StatelessWidget {
  const ListDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(100, (index) {
        return ListTile(
          leading: const Icon(Icons.people),
          trailing: const Icon(Icons.delete),
          title: Text('联系人 : ${index + 1}', style: const TextStyle(fontSize: 30)),
          subtitle: Text('电话号码: 11111155555${index + 1}'),
        );
      }),
    );
  }
}
