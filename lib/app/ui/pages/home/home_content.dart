import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/category_model.dart';
import 'package:svran_flutter_study/app/core/services/json_parse.dart';
import 'package:svran_flutter_study/public_code.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

import 'home_category_item.dart';

class SvranHomeContent extends StatelessWidget {
  const SvranHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryModel>(
      future: SvranJsonParse.getCategoriesData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final categories = snapshot.data!.list!;
          return GridView.builder(
            controller: ScrollController(),
            padding: EdgeInsets.all(20.px),
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.px,
              mainAxisSpacing: 20.px,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return SvranHomeCategoryItemWidget(category: categories[index]);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
