import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:svran_flutter_study/ws/slivers/s07/sliver_list_detail_page.dart';

class SliverListInstanceDemoPage extends StatefulWidget {
  const SliverListInstanceDemoPage({Key? key}) : super(key: key);

  @override
  State<SliverListInstanceDemoPage> createState() => _SliverListInstanceDemoPageState();
}

class _SliverListInstanceDemoPageState extends State<SliverListInstanceDemoPage> {
  List<Member> members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SliverList 实例"),
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
              sid: row['sid'],
              gid: row['gid'],
              gname: row['gname'],
              sname: row['sname'],
              fname: row['fname'],
              pinyin: row['pinyin'],
              abbr: row['abbr'],
              tid: row['tid'],
              tname: row['tname'],
              pid: row['pid'],
              pname: row['pname'],
              nickname: row['nickname'],
              company: row['company'],
              join_day: row['join_day'],
              height: row['height'],
              birth_day: row['birth_day'],
              star_sign_12: row['star_sign_12'],
              star_sign_48: row['star_sign_48'],
              birth_place: row['birth_place'],
              speciality: row['speciality'],
              hobby: row['hobby'],
              experience: row['experience'],
              catch_phrase: row['catch_phrase'],
              weibo_uid: row['weibo_uid'],
              weibo_verifier: row['weibo_verifier'],
              blood_type: row['blood_type'],
              tieba_kw: row['tieba_kw'],
              status: row['status'],
              // ranking: row['ranking'],
              pocket_id: row['pocket_id'],
              tcolor: row['tcolor'],
              gcolor: row['gcolor'],
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
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SliverListInstanceDetailDemoPage(member: m),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: CircleAvatar(
                    child: Image.network(m.avatarUrl),
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(m.name),
              ],
            ),
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
  final String sid;
  final String gid;
  final String gname;
  final String sname;
  final String fname;
  final String pinyin;
  final String abbr;
  final String tid;
  final String tname;
  final String pid;
  final String pname;
  final String nickname;
  final String company;
  final String join_day;
  final String height;
  final String birth_day;
  final String star_sign_12;
  final String star_sign_48;
  final String birth_place;
  final String speciality;
  final String hobby;
  final String experience;
  final String catch_phrase;
  final String weibo_uid;
  final String weibo_verifier;
  final String blood_type;
  final String tieba_kw;
  final String status;
  // final String ranking;
  final String pocket_id;
  final String tcolor;
  final String gcolor;

  Member({
    required this.id,
    required this.name,
    required this.team,
    required this.sid,
    required this.gid,
    required this.gname,
    required this.sname,
    required this.fname,
    required this.pinyin,
    required this.abbr,
    required this.tid,
    required this.tname,
    required this.pid,
    required this.pname,
    required this.nickname,
    required this.company,
    required this.join_day,
    required this.height,
    required this.birth_day,
    required this.star_sign_12,
    required this.star_sign_48,
    required this.birth_place,
    required this.speciality,
    required this.hobby,
    required this.experience,
    required this.catch_phrase,
    required this.weibo_uid,
    required this.weibo_verifier,
    required this.blood_type,
    required this.tieba_kw,
    required this.status,
    // required this.ranking,
    required this.pocket_id,
    required this.tcolor,
    required this.gcolor,
  });

  String get avatarUrl => "https://www.snh48.com/images/member/zp_$id.jpg";

  @override
  String toString() {
    return 'Member{id: $id, name: $name}';
  }
}
