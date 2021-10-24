import 'dart:ui';

class SvranSizeFit {
  static double physicalWidth = 0.0;
  static double physicalHeight = 0.0;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double dpr = 0.0;
  static double statusHeight = 0.0;
  static double _rpx = 0.0;
  static double _px = 0.0;

  static void init({double widthOfDesign = 750.0}) {
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    dpr = window.devicePixelRatio;

    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    statusHeight = window.padding.top / dpr;

    _rpx = screenWidth / widthOfDesign;
    _px = screenWidth / widthOfDesign * 2;
  }

  static double toRpx(double size) {
    return _rpx * size;
  }

  static double toPx(double size) {
    return _px * size;
  }
}

extension FitSizeDouble on double {
  // double rpx() {
  //   return SvranSizeFit.toRpx(this);
  // }
  double get rpx {
    return SvranSizeFit.toRpx(this);
  }

  double get px {
    return SvranSizeFit.toPx(this);
  }
}

extension FitSizeInt on int {
  // double rpx() {
  //   return SvranSizeFit.toRpx(toDouble());
  // }
  double get rpx {
    return SvranSizeFit.toRpx(toDouble());
  }

  double get px {
    return SvranSizeFit.toPx(toDouble());
  }
}
