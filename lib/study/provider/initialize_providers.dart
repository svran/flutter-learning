import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:svran_flutter_study/study/provider/model/user_info.dart';
import 'package:svran_flutter_study/study/provider/view_model/counter_view_model.dart';
import 'package:svran_flutter_study/study/provider/view_model/user_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => SvranCounterViewModel()),
  ChangeNotifierProvider(create: (context) => SvranUserViewModel(UserInfo())),
];
