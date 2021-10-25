import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';

class SvranFavorViewModel extends ChangeNotifier {
  final List<SvranMeal> _favMeals = [];

  List<SvranMeal> get favMeals => _favMeals;

  void addMeal(SvranMeal? meal) {
    if (meal == null) return;
    _favMeals.add(meal);
    notifyListeners();
  }

  void removeMeal(SvranMeal? meal) {
    if (meal == null) return;
    _favMeals.remove(meal);
    notifyListeners();
  }

  bool isFavor(SvranMeal? meal) {
    if (meal == null) return false;
    return _favMeals.contains(meal);
  }

  void handleMeal(SvranMeal? meal) {
    if (isFavor(meal)) {
      removeMeal(meal);
    } else {
      addMeal(meal);
    }
  }
}
