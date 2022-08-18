import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:svran_flutter_study/study/screen_adaptation/size_fit.dart';

class SvranPixel extends StatefulWidget {
  final WidgetBuilder? builder;

  const SvranPixel({Key? key, required this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SvranPixelState();
  }
}

class _SvranPixelState extends State<SvranPixel> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  static MediaQueryData? of(BuildContext ctx) {
    return ctx.dependOnInheritedWidgetOfExactType<_SvranPixelInherited>()?.data;
  }

  @override
  void didChangeMetrics() {
    setState(() {
      RendererBinding.instance.scheduleWarmUpFrame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    SvranSizeFit.init();
    return _SvranPixelInherited(
      data: data,
      child: Builder(
        builder: (ctx) {
          return widget.builder!(ctx);
        },
      ),
    );
  }
}

class _SvranPixelInherited extends InheritedWidget {
  final MediaQueryData? data;

  const _SvranPixelInherited({Key? key, this.data, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant _SvranPixelInherited oldWidget) {
    return data != oldWidget.data;
  }
}
