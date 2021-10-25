import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svran_flutter_study/app/core/model/meal_model.dart';
import 'package:svran_flutter_study/app/core/view_model/svran_fav_view_model.dart';
import 'package:svran_flutter_study/app/ui/pages/detail/detail_content.dart';
import 'package:svran_flutter_study/app/ui/pages/detail/detail_floationg_button.dart';

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
      body: SvranDetailContent(meal),
      floatingActionButton: SvranDetailFloatingButton(meal),
    );
  }
}
