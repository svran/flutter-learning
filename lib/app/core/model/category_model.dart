import 'dart:convert' show json;

class CategoryModel {

  List<CategoryItem?>? category;

  CategoryModel.fromParams({this.category});

  factory CategoryModel(Object jsonStr) => jsonStr is String ? CategoryModel.fromJson(json.decode(jsonStr)) : CategoryModel.fromJson(jsonStr);

  static CategoryModel? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : CategoryModel(jsonStr);

  CategoryModel.fromJson(jsonRes) {
    category = jsonRes['category'] == null ? null : [];

    for (var categoryItem in category == null ? [] : jsonRes['category']){
      category!.add(categoryItem == null ? null : CategoryItem.fromJson(categoryItem));
    }
  }

  @override
  String toString() {
    return '{"category": $category}';
  }

  String toJson() => this.toString();
}

class CategoryItem {

  String? color;
  String? id;
  String? title;

  CategoryItem.fromParams({this.color, this.id, this.title});

  CategoryItem.fromJson(jsonRes) {
    color = jsonRes['color'];
    id = jsonRes['id'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"color": ${color != null?'${json.encode(color)}':'null'}, "id": ${id != null?'${json.encode(id)}':'null'}, "title": ${title != null?'${json.encode(title)}':'null'}}';
  }

  String toJson() => this.toString();
}