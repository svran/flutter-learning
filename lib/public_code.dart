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
