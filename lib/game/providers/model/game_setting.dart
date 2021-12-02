class SvranGameSetting {
  /// 初始血量
  double blood = 100;

  /// 卡池总数
  int cardCount = 100;

  /// 手牌上限
  int handCard = 3;

  /// 每回合出牌量
  int roundCard = 1;

  /// 每回合抽卡数
  int drawCard = 1;

  SvranGameSetting(this.blood, this.cardCount, this.handCard, this.roundCard, this.drawCard);
}
