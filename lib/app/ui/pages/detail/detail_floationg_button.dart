import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/app/core/view_model/svran_fav_view_model.dart';

class SvranDetailFloatingButton extends StatelessWidget {
  final SvranMeal? meal;

  const SvranDetailFloatingButton(this.meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SvranFavorViewModel>(
      builder: (context, value, child) {
        final icon = value.isFavor(meal) ? Icons.favorite : Icons.favorite_border;
        return FloatingActionButton(
          child: Icon(icon),
          onPressed: () => value.handleMeal(meal),
        );
      },
    );
  }
}
