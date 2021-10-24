import 'package:flutter/material.dart';
import 'package:svran_flutter_study/study/provider/model/user_info.dart';

class SvranUserViewModel extends ChangeNotifier {
  late UserInfo _user;

  SvranUserViewModel(this._user);

  UserInfo get user => _user;

  set user(UserInfo value) {
    _user = value;
    notifyListeners();
  }
}
