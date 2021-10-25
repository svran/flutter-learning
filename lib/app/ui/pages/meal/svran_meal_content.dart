import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/core/model/category_model.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/app/core/view_model/meal_view_model.dart';
import 'package:svran_flutter_study/app/ui/pages/meal/svran_meal_content_list_item.dart';
import 'package:svran_flutter_study/public_code.dart';

class SvranMealContent extends StatelessWidget {
  static const String routeName = "/SvranMealContent";

  const SvranMealContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 在meal 顶层路由拿也行, 这里再拿一次依然可以.
    final category = ModalRoute.of(context)?.settings.arguments as CategoryItem?;
    // svranToast(category.toString());
    // return ConsumerWidget(category: category);
    return Selector<SvranMealViewModel, List<SvranMeal>>(shouldRebuild: (previous, next) {
      var b = listEquals(previous, next);
      logger.d("Svran: Flutter -> 列表相同:$b");
      return !b;
    }, builder: (context, value, child) {
      return ListView.builder(
        itemCount: value.length,
        itemBuilder: (context, index) {
          return SvranMealContentListItem(value[index]);
        },
      );
    }, selector: (p0, p1) {
      // logger.d("Svran: Flutter -> ${p1.meals.length}");
      return p1.meals.where((element) {
        return element.categories?.contains(category?.id) == true;
      }).toList();
    });
  }
}

/// 这里需要过滤数据, 不建议用Consumer ,建议使用Selector
class ConsumerWidget extends StatelessWidget {
  const ConsumerWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryItem? category;

  @override
  Widget build(BuildContext context) {
    return Consumer<SvranMealViewModel>(
      builder: (context, value, child) {
        final meals = value.meals.where((element) => element.categories?.contains(category?.id) == true).toList();
        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(meals[index].title ?? ""),
            );
          },
        );
      },
    );
  }
}
