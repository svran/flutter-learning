import 'dart:math';
import 'dart:ui';

import 'package:logger/logger.dart';
import 'package:svran_flutter_study/ext/logger/svran_pretty_printer.dart';

var logger = Logger(
  printer: SvranPrettyPrinter(
    methodCount: 1,
    methodCountOffset: 3,
  ), // Use the PrettyPrinter to format and print log
);

randomColor() {
  return Color.fromARGB(
    255,
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
  );
}

colorByIndex(int index) {
  var colorIndex1 = (index % 6) + 1;
  var colorValue1 = index % 10; // 个位
  var colorValue2 = index ~/ 10 % 10; // 十位
  var colorValue3 = index ~/ 100 % 10; // 百位
  var colorValue0 = index ~/ 1000 % 10; // 千位
  switch (colorIndex1) {
    case 0:
      break;
    case 1:
      return Color.fromARGB(255 - colorValue0 * 28, 255 - colorValue1 * 28, colorValue2 * 28, colorValue3 * 28);
    case 2:
      return Color.fromARGB(255 - colorValue1 * 28, colorValue2 * 28, 255 - colorValue3 * 28, colorValue0 * 28);
    case 3:
      return Color.fromARGB(255 - colorValue2 * 28, colorValue3 * 28, colorValue0 * 28, 255 - colorValue1 * 28);
    case 4:
      return Color.fromARGB(255 - colorValue3 * 28, colorValue0 * 28, 255 - colorValue1 * 28, 255 - colorValue2 * 28);
    case 5:
      return Color.fromARGB(255 - colorValue3 * 28, 255 - colorValue0 * 28, colorValue1 * 28, 255 - colorValue2 * 28);
    case 6:
      return Color.fromARGB(255 - colorValue3 * 28, 255 - colorValue0 * 28, 255 - colorValue1 * 28, colorValue2 * 28);
  }
  return Color.fromARGB(
    255,
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
    Random.secure().nextInt(255),
  );
}
