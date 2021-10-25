import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:svran_flutter_study/app/core/view_model/filter_view_model.dart';
import 'package:svran_flutter_study/app/core/view_model/meal_view_model.dart';
import 'package:svran_flutter_study/app/core/view_model/svran_fav_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => SvranFavorViewModel()),
  ChangeNotifierProvider(create: (context) => SvranFilterViewModel()),

  // ChangeNotifierProvider(create: (context) => SvranMealViewModel()),
  // 这里就不再用ChangeNotifierProvider 注册 SvranMealViewModel
  // 这里是让 MealModel 依赖FilterModel
  ChangeNotifierProxyProvider<SvranFilterViewModel, SvranMealViewModel>(
    create: (context) => SvranMealViewModel(),
    update: (context, SvranFilterViewModel filterVm, SvranMealViewModel? mealVm) {
      mealVm!.updateFilters(filterVm);
      return mealVm;
    },
  )
];
