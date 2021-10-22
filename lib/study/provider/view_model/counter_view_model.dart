import 'package:flutter/cupertino.dart';

// class SvranCounterViewModel with ChangeNotifier{
// 创建 共享 的数据
class SvranCounterViewModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    notifyListeners();
  }
}
