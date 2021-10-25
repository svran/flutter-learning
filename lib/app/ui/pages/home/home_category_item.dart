import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/category_model.dart';
import 'package:svran_flutter_study/app/ui/pages/meal/meal.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranHomeCategoryItemWidget extends StatelessWidget {
  final CategoryItem? category;

  const SvranHomeCategoryItemWidget({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int 转 十六进制.
    final colorInt = int.parse(category?.color ?? "EEEEEE", radix: 16);
    // 将透明度 加入.
    var cColor = (colorInt | 0xFF000000);

    final bgColor = Color(cColor);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(SvranMealScreen.routeName, arguments: category);
        svranToast("${category?.id}");
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.px),
          gradient: LinearGradient(
            tileMode: TileMode.repeated,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bgColor.withOpacity(0.5),
              bgColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          category?.title ?? "",
          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold, shadows: [
            Shadow(
              color: Colors.white,
              offset: Offset.fromDirection(0.5),
              blurRadius: 1,
            )
          ]),
        ),
      ),
    );
  }
}
