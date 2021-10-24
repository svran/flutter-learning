import 'dart:convert' show json;

class CategoryModel {

  List<CategoryItem?>? list;

  CategoryModel.fromParams({this.list});

  factory CategoryModel(Object jsonStr) => jsonStr is String ? CategoryModel.fromJson(json.decode(jsonStr)) : CategoryModel.fromJson(jsonStr);

  static CategoryModel? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : CategoryModel(jsonStr);

  CategoryModel.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes){
      list!.add(listItem == null ? null : CategoryItem.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }

  String toJson() => this.toString();
}

class CategoryItem {

  int? courseId;
  int? id;
  int? order;
  int? parentChapterId;
  int? visible;
  bool? userControlSetTop;
  String? name;
  List<dynamic?>? children;

  CategoryItem.fromParams({this.courseId, this.id, this.order, this.parentChapterId, this.visible, this.userControlSetTop, this.name, this.children});

  CategoryItem.fromJson(jsonRes) {
    courseId = jsonRes['courseId'];
    id = jsonRes['id'];
    order = jsonRes['order'];
    parentChapterId = jsonRes['parentChapterId'];
    visible = jsonRes['visible'];
    userControlSetTop = jsonRes['userControlSetTop'];
    name = jsonRes['name'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']){
      children!.add(childrenItem);
    }
  }

  @override
  String toString() {
    return '{"courseId": $courseId, "id": $id, "order": $order, "parentChapterId": $parentChapterId, "visible": $visible, "userControlSetTop": $userControlSetTop, "name": ${name != null?'${json.encode(name)}':'null'}, "children": $children}';
  }

  String toJson() => this.toString();
}