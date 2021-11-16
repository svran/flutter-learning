import 'package:flutter/material.dart';

extension RelativeRectExt on RelativeRect {
  static RelativeRect fromOffsetExt(Offset offset) {
    return RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, offset.dy);
  }
}
