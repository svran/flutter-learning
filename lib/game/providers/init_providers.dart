import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:svran_flutter_study/game/providers/view_model/cards_view_model.dart';
import 'package:svran_flutter_study/game/providers/view_model/game_player_view_model.dart';
import 'package:svran_flutter_study/game/providers/view_model/game_setting_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => SvranGameCardsViewModel()),
  ChangeNotifierProvider(create: (context) => SvranGameSettingViewModel()),
  ChangeNotifierProvider(create: (context) => SvranGamePlayerViewModel()),
];
