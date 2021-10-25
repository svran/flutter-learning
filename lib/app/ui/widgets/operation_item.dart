import 'package:flutter/material.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranOperationItem extends StatelessWidget {
  final Widget? _icon;
  final String? _title;
  final Color _textColor;

  const SvranOperationItem({
    Key? key,
    Widget? icon,
    String? title,
    Color textColor = Colors.black,
  })  : _icon = icon,
        _title = title,
        _textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _icon == null ? Container() : _icon!,
        SizedBox(width: 3.px),
        Text(
          _title ?? "",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: _textColor),
        ),
      ],
    );
  }
}
