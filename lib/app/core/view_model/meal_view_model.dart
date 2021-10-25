import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/app/core/services/meal_request.dart';

class SvranMealViewModel extends ChangeNotifier {
  List<SvranMeal> _meals = [];

  List<SvranMeal> get meals => _meals;

  SvranMealViewModel() {
    SvranMealRequest.getMealData().then((value) {
      _meals = value;
      notifyListeners();
    });
  }
}
