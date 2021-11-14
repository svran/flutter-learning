import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RenderObjectDemoPage extends StatefulWidget {
  const RenderObjectDemoPage({Key? key}) : super(key: key);

  @override
  State<RenderObjectDemoPage> createState() => _RenderObjectDemoPageState();
}

class _RenderObjectDemoPageState extends State<RenderObjectDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自己手动写一个RenderObject"),
      ),
      body: Container(
        color: Colors.red,
        child: ShadowBox(
          distance: 8,
          child: Icon(Icons.category, size: 100),
        ),
      ),
    );
  }
}

class ShadowBox extends SingleChildRenderObjectWidget {
  final double distance;

  ShadowBox({Widget? child, required this.distance}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShadowBox(distance);
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderShadowBox renderObject) {
    renderObject.distance = distance;
  }
}

class RenderShadowBox extends RenderProxyBox with DebugOverflowIndicatorMixin {
  double distance;

  RenderShadowBox(this.distance);

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    context.pushOpacity(offset, 127, (context, offset) {
      context.paintChild(child!, offset + Offset(distance, distance));
    });
    paintOverflowIndicator(
      context,
      offset,
      offset & size,
      offset & child!.size,
      // Rect.fromLTWH(0, 0, size.width, size.height),
      // Rect.fromLTWH(0, 0, 320, 300),
    );
  }
}

///
class RenderShadowBox2 extends RenderBox with RenderObjectWithChildMixin {
  double distance;

  RenderShadowBox2(this.distance);

  @override
  void performLayout() {
    child!.layout(constraints, parentUsesSize: true);
    size = (child as RenderBox).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    context.pushOpacity(offset, 127, (context, offset) {
      context.paintChild(child!, offset + Offset(distance, distance));
    });
  }
}
