import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/app/ui/pages/detail/detail.dart';
import 'package:svran_flutter_study/app/ui/widgets/operation_item.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranMealContentListItem extends StatelessWidget {
  final SvranMeal _meal;

  const SvranMealContentListItem(this._meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // logger.d("Svran: Flutter -> $meal");
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(SvranDetailScreen.routeName, arguments: _meal);
      },
      child: Card(
        margin: EdgeInsets.all(10.px),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.px)),
        child: Column(
          children: [
            buildBasicInfo(context),
            buildOperationInfo(),
          ],
        ),
      ),
    );
  }

  Widget buildBasicInfo(BuildContext context) {
    var cardRadius = Radius.circular(12.px);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: cardRadius, topRight: cardRadius),
          child: Image.network(
            _meal.imageUrl ?? "",
            width: double.infinity,
            height: 250.px,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 10.px,
          bottom: 10.px,
          child: Container(
            width: 300.px,
            padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 6.px),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6.px),
            ),
            child: Text(
              _meal.title ?? "",
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOperationInfo() {
    return Padding(
      padding: EdgeInsets.all(16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvranOperationItem(
            icon: const Icon(Icons.schedule),
            title: "${_meal.duration}分钟",
          ),
          SvranOperationItem(
            icon: const Icon(Icons.restaurant),
            title: "${_meal.complexStr}",
          ),
          SvranOperationItem(
            icon: const Icon(Icons.favorite),
            title: "未收藏",
          ),
        ],
      ),
    );
  }
}
