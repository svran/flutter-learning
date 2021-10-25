import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/app/core/services/meal_request.dart';
import 'package:svran_flutter_study/app/core/view_model/filter_view_model.dart';

class SvranMealViewModel extends ChangeNotifier {
  List<SvranMeal> _meals = [];

  late SvranFilterViewModel _filterVm; // 这里存放对过滤条件的依赖

  List<SvranMeal> get meals {
    return _meals.where((meal) { // 通过过滤条件做筛选
      if (_filterVm.isGlutenFree == true && !(meal.isGlutenFree ?? false) == true) return false;
      if (_filterVm.isLactoseFree == true && !(meal.isLactoseFree ?? false) == true) return false;
      if (_filterVm.isVegetarian == true && !(meal.isVegetarian ?? false) == true) return false;
      if (_filterVm.isVegan == true && !(meal.isVegan ?? false) == true) return false;
      return true;
    }).toList();
  }

  void updateFilters(SvranFilterViewModel filterVm) {
    _filterVm = filterVm;
  }

  SvranMealViewModel() {
    SvranMealRequest.getMealData().then((value) {
      _meals = value;
      notifyListeners();
    });
  }
}
