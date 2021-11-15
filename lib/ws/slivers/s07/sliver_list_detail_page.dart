import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ws/slivers/s07/sliver_list.dart';

class SliverListInstanceDetailDemoPage extends StatefulWidget {
  final Member member;

  const SliverListInstanceDetailDemoPage({Key? key, required this.member}) : super(key: key);

  @override
  State<SliverListInstanceDetailDemoPage> createState() => _SliverListInstanceDetailDemoPageState();
}

class _SliverListInstanceDetailDemoPageState extends State<SliverListInstanceDetailDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.member.name),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.member.name),
              background: Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Hero(
                      tag: widget.member.id,
                      child: ClipOval(child: Image.network(widget.member.avatarUrl, fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildInfo("拼音", widget.member.pinyin),
              _buildInfo("加入所属", widget.member.pname),
              _buildInfo("昵称", widget.member.nickname),
              _buildInfo("加入日期", widget.member.join_day),
              _buildInfo("身高", "${widget.member.height} cm"),
              _buildInfo("生日", widget.member.birth_day),
              _buildInfo("星座", widget.member.star_sign_12),
              _buildInfo("出生地", widget.member.birth_place),
              _buildInfo("特长", widget.member.speciality),
              _buildInfo("兴趣爱好", widget.member.hobby),
            ]),
          )
        ],
      ),
    );
  }

  _buildInfo(String label, String context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label),
            Text(context, textAlign: TextAlign.end),
          ],
        ),
      ),
    );
  }
}
