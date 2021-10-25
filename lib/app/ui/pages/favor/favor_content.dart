import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/core/view_model/svran_fav_view_model.dart';
import 'package:svran_flutter_study/app/ui/pages/meal/svran_meal_content_list_item.dart';

class SvranFavorContent extends StatelessWidget {
  const SvranFavorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SvranFavorViewModel>(
      builder: (context, value, child) {
        if (value.favMeals.isEmpty) {
          return const Center(
            child: Text('未收藏任何东西'),
          );
        }
        return ListView.builder(
          itemCount: value.favMeals.length,
          itemBuilder: (context, index) {
            return SvranMealContentListItem(value.favMeals[index]);
          },
        );
      },
    );
  }
}
