import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class SvranMiui10AnimBuilder extends BaseAnimationBuilder {
  const SvranMiui10AnimBuilder();

  @override
  Widget buildWidget(
    BuildContext context,
    Widget child,
    AnimationController controller,
    double percent,
  ) {
    final double opacity = min(1.0, percent + 0.2);
    // final double offset = (1 - percent) * 20;
    var anim = Tween(begin: 60.0, end: 0.0).chain(CurveTween(curve: Curves.elasticOut)).animate(controller);

    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        child: child,
        offset: Offset(0, anim.value),
      ),
    );
  }
}
