import 'package:flutter/material.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranOperationItem extends StatelessWidget {
  final Widget? _icon;
  final String? _title;

  const SvranOperationItem({
    Key? key,
    Widget? icon,
    String? title,
  })  : _icon = icon,
        _title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _icon == null ? Container() : _icon!,
        SizedBox(
          width: 3.px,
        ),
        Text(
          _title ?? "",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
