import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListViewToSliverListDemoPage extends StatefulWidget {
  const ListViewToSliverListDemoPage({Key? key}) : super(key: key);

  @override
  State<ListViewToSliverListDemoPage> createState() => _ListViewToSliverListDemoPageState();
}

class _ListViewToSliverListDemoPageState extends State<ListViewToSliverListDemoPage> {
  List<Member> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("从List到Sliver"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          const url = "https://h5.48.cn/resource/jsonp/allmembers.php?gid=10";
          final res = await http.get(Uri.parse(url));
          if (res.statusCode != 200) {
            throw ("error");
          }
          final json = convert.jsonDecode(res.body);
          members = json['rows'].map<Member>((row) {
            return Member(
              id: row['sid'],
              name: row['sname'],
              team: row['tname'],
            );
          }).toList();
          setState(() {});
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final m = members[index];
                return ListTile(
                  trailing: Text(m.team),
                  title: Text(m.name),
                  subtitle: Text(m.id),
                  leading: ClipOval(
                    child: CircleAvatar(
                      child: Image.network(m.avatarUrl),
                      backgroundColor: Colors.white,
                    ),
                  ),
                );
              },
              childCount: members.length,
            ),
          )
        ],
      ),
    );
  }
}

class Member {
  final String id;
  final String name;
  final String team;

  Member({
    required this.id,
    required this.name,
    required this.team,
  });

  String get avatarUrl => "https://www.snh48.com/images/member/zp_$id.jpg";

  @override
  String toString() {
    return 'Member{id: $id, name: $name}';
  }
}
