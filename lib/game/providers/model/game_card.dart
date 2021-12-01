class SvranGameCard {
  String name;
  String cardDesc;
  String cardImgPath;
  int cardId;
  int value;
  int max;
  int min;
  int cardType;

  SvranGameCard(this.name, this.cardDesc, this.cardImgPath, this.cardId, this.value, this.max, this.min, this.cardType);
}

enum SvranGameCardType {
  kill,
  reply,
  buff,
  undefine,
}
