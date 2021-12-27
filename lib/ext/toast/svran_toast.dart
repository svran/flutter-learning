import 'package:oktoast/oktoast.dart';

svranToast(String msg) {
  dismissAllToast(showAnim: true);
  final t = msg.length ~/ 5 < 3 ? 3 : msg.length ~/ 5;
  showToast(
    msg,
    duration: Duration(seconds: t > 10 ? 10 : t),
  );
}
