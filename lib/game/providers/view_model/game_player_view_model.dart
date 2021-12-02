import 'package:flutter/material.dart';
import 'package:svran_flutter_study/game/providers/model/game_player.dart';

class SvranGamePlayerViewModel extends ChangeNotifier {
  SvranGamePlayer gamePlayer = SvranGamePlayer(GamePlayer.player1, 100, 100);

  SvranGamePlayerViewModel();

  changePlayer() {
    gamePlayer.player = GamePlayer.player1 == gamePlayer.player ? GamePlayer.player2 : GamePlayer.player1;
    notifyListeners();
  }

  setBlood(double blood) {
    gamePlayer.player1Blood = blood;
    gamePlayer.player2Blood = blood;
    notifyListeners();
  }

  changeBlood(double addBlood) {
    if (GamePlayer.player1 == gamePlayer.player) {
      gamePlayer.player1Blood += addBlood;
    }
    if (GamePlayer.player2 == gamePlayer.player) {
      gamePlayer.player2Blood += addBlood;
    }
    notifyListeners();
  }
}
