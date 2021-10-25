import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranDetailContent extends StatelessWidget {
  final SvranMeal? meal;

  const SvranDetailContent(this.meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBannerImage(),
          buildMakeTitle(context, "制作材料"),
          buildMakeMaterial(),
          buildMakeTitle(context, "制作步骤"),
          buildMakeSteps(),
          SizedBox(height: 30.px),
        ],
      ),
    );
  }

  Widget buildBannerImage() {
    return SizedBox(
      width: double.infinity,
      child: Image.network(meal?.imageUrl ?? ""),
    );
  }

  Widget buildMakeMaterial() {
    return buildMakeContent(
      child: ListView.builder(
        shrinkWrap: true,
        // 这个解决List中嵌套List. 解决hasSize问题.
        physics: const NeverScrollableScrollPhysics(),
        itemCount: meal?.ingredients?.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 10.px),
              child: Text(meal?.ingredients?[index] ?? ""),
            ),
          );
        },
      ),
    );
  }

  Widget buildMakeSteps() {
    return buildMakeContent(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: meal?.steps?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('#$index'),
            ),
            title: Text(meal?.steps?[index] ?? ""),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1.px),
      ),
    );
  }

  Widget buildMakeTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.px),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget buildMakeContent({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.px),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.px),
      ),
      padding: EdgeInsets.all(8.px),
      child: child,
    );
  }
}
