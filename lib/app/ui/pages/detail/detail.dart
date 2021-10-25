import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';

class SvranDetailScreen extends StatelessWidget {
  static const String routeName = "/SvranDetailScreen";

  const SvranDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as SvranMeal?;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal?.title ?? ""),
      ),
      body: Center(
        child: Text(meal?.title ?? ""),
      ),
    );
  }
}
