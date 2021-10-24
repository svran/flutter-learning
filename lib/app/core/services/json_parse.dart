import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/app/core/model/category_model.dart';
import 'package:svran_flutter_study/public_code.dart';

class SvranJsonParse {
  static Future<CategoryModel> getCategoriesData() async {
    // 加载json
    final jsonRes = await rootBundle.loadString("assets/json/category.json");
    // int 转 十六进制.
    final colorInt = int.parse("FE0023", radix: 16);
    // 将透明度 加入.
    var cColor = (colorInt | 0xFF000000);
    // await Future.delayed(const Duration(seconds: 3));
    return CategoryModel.fromJson(json.decode(jsonRes));
  }
}

extension CategoryItemExt1 on CategoryItem {
  // Color get color {
  //   return
  // }
  Color getColor(int index) {
    var m = index % 3;
    switch (m) {
      case 0:
        return Color.fromARGB(255, index * 80, index * 20, index * 10);
      case 1:
        return Color.fromARGB(255, index * 20, index * 10, index * 80);
      case 2:
        return Color.fromARGB(255, index * 10, index * 80, index * 20);
    }
    logger.e("Svran: Flutter -> 这是什么鬼? $m");
    return const Color(0xFFFFFFFF);
  }
}
