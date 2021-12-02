class SvranGamePlayer {
  GamePlayer player;
  double player1Blood;
  double player2Blood;

  SvranGamePlayer(this.player, this.player1Blood, this.player2Blood);

  double playerBlood() {
    if (GamePlayer.player1 == player) {
      return player1Blood;
    }
    if (GamePlayer.player2 == player) {
      return player2Blood;
    }
    return 0;
  }
}

enum GamePlayer {
  player1,
  player2,
}
