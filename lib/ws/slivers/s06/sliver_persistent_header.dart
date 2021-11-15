import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SliverPersistentHeaderSliverListDemoPage extends StatefulWidget {
  const SliverPersistentHeaderSliverListDemoPage({Key? key}) : super(key: key);

  @override
  State<SliverPersistentHeaderSliverListDemoPage> createState() => _SliverPersistentHeaderSliverListDemoPageState();
}

class _SliverPersistentHeaderSliverListDemoPageState extends State<SliverPersistentHeaderSliverListDemoPage> {
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
      body: Scrollbar(
        isAlwaysShown: true,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(), // 这个用于防止第一个 Header 不能跟着下拉走
            SliverPersistentHeader(pinned: true, delegate: _MyDelegate("Team SII", Color(0xFF91CDEB))),
            _buildTeamList("SII"),
            SliverPersistentHeader(pinned: true, delegate: _MyDelegate("Team NII", Color(0xFFAE86BB))),
            _buildTeamList("NII"),
            SliverPersistentHeader(pinned: true, delegate: _MyDelegate("Team HII", Color(0xFFF39800))),
            _buildTeamList("HII"),
            SliverPersistentHeader(pinned: true, delegate: _MyDelegate("Team X", Color(0xFFA9CC29))),
            _buildTeamList("X"),
          ],
        ),
      ),
    );
  }

  SliverGrid _buildTeamList(String teamName) {
    final teamMembers = members.where((element) => element.team == teamName).toList();
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final m = teamMembers[index];
          return Column(
            children: [
              Hero(
                tag: m.id,
                child: ClipOval(
                  child: CircleAvatar(
                    child: Image.network(m.avatarUrl),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Text(m.name),
            ],
          );
        },
        childCount: teamMembers.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
    );
  }
}

class _MyDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color color;

  _MyDelegate(this.title, this.color);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 32,
      child: FittedBox(child: Text(title)),
      color: color,
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant _MyDelegate oldDelegate) {
    return oldDelegate.title != title;
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
