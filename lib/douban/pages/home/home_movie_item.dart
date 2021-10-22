import 'package:flutter/material.dart';
import 'package:svran_flutter_study/douban/model/home_model.dart';
import 'package:svran_flutter_study/douban/widget/dashed_line.dart';
import 'package:svran_flutter_study/douban/widget/star_rating.dart';

class SvranHomeMovieItem extends StatelessWidget {
  final DataItem? movie;

  const SvranHomeMovieItem(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 8,
          color: Color(0xFFEEEEEE),
        ),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          const SizedBox(height: 8),
          buildContent(),
          const SizedBox(height: 8),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 238, 205, 144), borderRadius: BorderRadius.circular(3)),
      child: Text(
        "${movie?.id ?? 0}",
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 131, 95, 36),
        ),
      ),
    );
  }

  Widget buildContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildContentImage(),
        const SizedBox(width: 8),
        buildContentInfo(),
        const SizedBox(width: 8),
        buildContentLine(),
        const SizedBox(height: 8),
        buildContentWish(),
      ],
    );
  }

  Widget buildFooter() {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(movie?.title ?? ""),
    );
  }

  Widget buildContentImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        movie?.envelopePic ?? "",
        height: 150,
      ),
    );
  }

  Widget buildContentInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContentInfoTitle(),
          const SizedBox(height: 8),
          buildContentInfoRate(),
          const SizedBox(height: 8),
          buildContentInfoDesc(),
        ],
      ),
    );
  }

  Widget buildContentLine() {
    return const SizedBox(
      height: 120,
      child: SvranDashedLine(
        axis: Axis.vertical,
        dashedWidth: 1,
        dashedHeight: 6,
        count: 10,
        color: Colors.pink,
      ),
    );
  }

  Widget buildContentWish() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.wb_incandescent_outlined,
            color: Colors.orange,
          ),
          Text(
            '想看',
            style: TextStyle(fontSize: 16, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget buildContentInfoTitle() {
    return Text.rich(TextSpan(
      children: [
        const WidgetSpan(
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.redAccent,
            size: 24,
          ),
        ),
        TextSpan(
          text: movie?.title ?? "",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: "(${movie?.niceDate ?? ""})",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        )
      ],
    ));
  }

  Widget buildContentInfoRate() {
    double _r = (movie?.userId ?? 0) % 10;
    return Row(
      children: [
        SvranStartRating(rating: _r, size: 20),
        const SizedBox(width: 6),
        Text("$_r"),
      ],
    );
  }

  Widget buildContentInfoDesc() {
    final gString = movie?.tags?.join(" ");
    final dString =
        "${movie?.shareUser ?? "(暂无用户)"} ${movie?.chapterName ?? "(暂无专题)"}-${movie?.superChapterName ?? "(暂无专题)"} ${movie?.link ?? "(暂无链接)"}";
    return Text(
      '$gString / $dString',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 16),
    );
  }
}
