import 'package:svran_flutter_study/config/config.dart';

class UserInfo {
  String nickName;
  int level;
  String imageUrl;

  UserInfo({
    this.nickName = "Svran",
    this.level = 1,
    this.imageUrl = ImageUrlConfig.baiduImgUrl,
  });
}
