import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

svranToast(String msg) {
  dismissAllToast(showAnim: true);
  showToast(
    msg,
    duration: Duration(seconds: msg.length ~/ 5 < 3 ? 3 : msg.length ~/ 5),
  );
}
