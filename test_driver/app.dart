import 'package:flutter_driver/driver_extension.dart';
import 'package:svran_flutter_study/app/main.dart' as app;
import 'package:svran_flutter_study/main.dart' as mainApp;
import 'package:svran_flutter_study/douban/main.dart' as dbApp;

main() {
  // 1. 初始化Driver
  enableFlutterDriverExtension();

  // 2. 启动应用程序
  mainApp.main();

  //
}
