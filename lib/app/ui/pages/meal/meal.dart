import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/category_model.dart';
import 'package:svran_flutter_study/app/ui/pages/meal/svran_meal_content.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';

class SvranMealScreen extends StatefulWidget {
  static const String routeName = "/meal";

  const SvranMealScreen({Key? key}) : super(key: key);

  @override
  State<SvranMealScreen> createState() => _SvranMealScreenState();
}

class _SvranMealScreenState extends State<SvranMealScreen> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as CategoryItem?;
    // svranToast(category.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(category?.title ?? ""),
      ),
      body: const SvranMealContent(),
    );
  }
}
