import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/ext/http/http_request.dart';

class SvranMealRequest {
  static Future<List<SvranMeal>> getMealData() async {
    const url = "/meal";
    final result = await HttpRequest.request(url);
    final mealArray = result["meal"];
    List<SvranMeal> meals = [];
    for (var json in mealArray) {
      meals.add(SvranMeal.fromJson(json));
    }
    return meals;
  }
}
