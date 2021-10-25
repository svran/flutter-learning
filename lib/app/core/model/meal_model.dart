import 'dart:convert' show json;

class SvranMealModel {
  List<SvranMeal?>? meal;

  SvranMealModel.fromParams({this.meal});

  factory SvranMealModel(Object jsonStr) =>
      jsonStr is String ? SvranMealModel.fromJson(json.decode(jsonStr)) : SvranMealModel.fromJson(jsonStr);

  static SvranMealModel? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : SvranMealModel(jsonStr);

  SvranMealModel.fromJson(jsonRes) {
    meal = jsonRes['meal'] == null ? null : [];

    for (var mealItem in meal == null ? [] : jsonRes['meal']) {
      meal!.add(mealItem == null ? null : SvranMeal.fromJson(mealItem));
    }
  }

  @override
  String toString() {
    return '{"meal": $meal}';
  }

  String toJson() => this.toString();
}

class SvranMeal {
  int? affordability;
  int? complexity;
  int? duration;
  bool? isGlutenFree;
  bool? isLactoseFree;
  bool? isVegan;
  bool? isVegetarian;
  String? id;
  String? imageUrl;
  String? title;
  List<String?>? categories;
  List<String?>? ingredients;
  List<String>? steps;

  SvranMeal.fromParams(
      {this.affordability,
      this.complexity,
      this.duration,
      this.isGlutenFree,
      this.isLactoseFree,
      this.isVegan,
      this.isVegetarian,
      this.id,
      this.imageUrl,
      this.title,
      this.categories,
      this.ingredients,
      this.steps});

  SvranMeal.fromJson(jsonRes) {
    affordability = jsonRes['affordability'];
    complexity = jsonRes['complexity'];
    duration = jsonRes['duration'];
    isGlutenFree = jsonRes['isGlutenFree'];
    isLactoseFree = jsonRes['isLactoseFree'];
    isVegan = jsonRes['isVegan'];
    isVegetarian = jsonRes['isVegetarian'];
    id = jsonRes['id'];
    imageUrl = jsonRes['imageUrl'];
    title = jsonRes['title'];
    categories = jsonRes['categories'] == null ? null : [];

    for (var categoriesItem in categories == null ? [] : jsonRes['categories']) {
      categories!.add(categoriesItem);
    }

    ingredients = jsonRes['ingredients'] == null ? null : [];

    for (var ingredientsItem in ingredients == null ? [] : jsonRes['ingredients']) {
      ingredients!.add(ingredientsItem);
    }

    steps = jsonRes['steps'] == null ? null : [];

    for (var stepsItem in steps == null ? [] : jsonRes['steps']) {
      steps!.add(stepsItem);
    }
  }

  @override
  String toString() {
    return '{"affordability": $affordability, "complexity": $complexity, "duration": $duration, "isGlutenFree": $isGlutenFree, "isLactoseFree": $isLactoseFree, "isVegan": $isVegan, "isVegetarian": $isVegetarian, "id": ${id != null ? '${json.encode(id)}' : 'null'}, "imageUrl": ${imageUrl != null ? '${json.encode(imageUrl)}' : 'null'}, "title": ${title != null ? '${json.encode(title)}' : 'null'}, "categories": ${categories != null ? '${json.encode(categories)}' : 'null'}, "ingredients": ${ingredients != null ? '${json.encode(ingredients)}' : 'null'}, "steps": $steps}';
  }

  String toJson() => this.toString();
}

List<String> _complexStrArr = ["简单", "中等", "困难"];

extension SvranMealExt1 on SvranMeal {
  get complexStr {
    return _complexStrArr[complexity ?? 0];
  }
}
