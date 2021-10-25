import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:svran_flutter_study/app/core/view_model/meal_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => SvranMealViewModel()),
];
