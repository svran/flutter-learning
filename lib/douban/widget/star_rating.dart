
import 'package:flutter/material.dart';

class SvranStartRating extends StatefulWidget {
  final double? rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;
  final Widget unselectedImage;
  final Widget selectedImage;

  SvranStartRating({
    Key? key,
    @required this.rating,
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.red,
    Widget? unselectedImage,
    Widget? selectedImage,
  })  : assert(rating != null),
        unselectedImage = unselectedImage ?? Icon(Icons.star_border, color: unselectedColor, size: size),
        selectedImage = selectedImage ?? Icon(Icons.star, color: selectedColor, size: size),
        super(key: key);

  @override
  _SvranStartRatingState createState() => _SvranStartRatingState();
}

class _SvranStartRatingState extends State<SvranStartRating> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(mainAxisSize: MainAxisSize.min, children: buildUnSelectedStar()),
      Row(mainAxisSize: MainAxisSize.min, children: buildSelectedStar()),
    ]);
  }

  buildUnSelectedStar() {
    return List.generate(
      widget.count,
          (index) => widget.unselectedImage,
    );
  }

  buildSelectedStar() {
    // 创建start
    List<Widget> stars = [];

    final star = widget.selectedImage;

    // 构建满星
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating! / oneValue).floor();
    for (var i = 0; i < entireCount; ++i) {
      stars.add(star);
    }
    // 构建部分填充星
    double leftWidth = ((widget.rating! / oneValue) - entireCount) * widget.size;

    final halfStar = ClipRect(
      clipper: SvranStarClipper(leftWidth),
      child: star,
    );
    stars.add(halfStar);

    if (stars.length > widget.count) {
      return stars.sublist(0, widget.count);
    }
    return stars;
  }
}

class SvranStarClipper extends CustomClipper<Rect> {
  double width;

  SvranStarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(SvranStarClipper oldClipper) {
    return width != oldClipper.width;
  }
}
