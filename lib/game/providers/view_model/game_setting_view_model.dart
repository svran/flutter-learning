import 'package:flutter/material.dart';
import 'package:svran_flutter_study/game/providers/model/game_setting.dart';

class SvranGameSettingViewModel extends ChangeNotifier {
  SvranGameSetting gameSetting = SvranGameSetting(100, 100, 5, 1, 1);

  SvranGameSettingViewModel();

  updateSetting({double? blood, int? cardCount, int? handCard, int? roundCard, int? drawCard}) {
    if (blood != null) gameSetting.blood = blood;
    if (cardCount != null) gameSetting.cardCount = cardCount;
    if (handCard != null) gameSetting.handCard = handCard;
    if (roundCard != null) gameSetting.roundCard = roundCard;
    if (drawCard != null) gameSetting.drawCard = drawCard;
    notifyListeners();
  }
}
