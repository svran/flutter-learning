import 'package:flutter/material.dart';
import 'package:svran_flutter_study/game/providers/model/game_card.dart';

class SvranGameCardsViewModel extends ChangeNotifier {
  late List<SvranGameCard> cards;

  SvranGameCardsViewModel();
}
