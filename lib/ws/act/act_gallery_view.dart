import 'package:flutter/material.dart';

class ActGalleryViewDemoPage extends StatefulWidget {
  const ActGalleryViewDemoPage({Key? key}) : super(key: key);

  @override
  State<ActGalleryViewDemoPage> createState() => _ActGalleryViewDemoPageState();
}

class _ActGalleryViewDemoPageState extends State<ActGalleryViewDemoPage> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("支持捏拉缩放手势的网格列表"),
      ),
      body: Scrollbar(
        controller: _controller,
        child: GalleryView.builder(
          controller: _controller,
          itemCount: 101,
          itemBuilder: (context, index) {
            // return MyImage(index: index);
            return FlutterLogo();
          },
        ),
      ),
    );
  }
}

class GalleryView extends StatefulWidget {
  final int? itemCount;
  final IndexedWidgetBuilder itemBuilder;

  final int initialPerRow;
  final int minPerRow;
  final int maxPerRow;

  final Duration duration;
  final ScrollController? controller;

  const GalleryView.builder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.initialPerRow = 3,
    this.minPerRow = 1,
    this.maxPerRow = 7,
    this.duration = const Duration(seconds: 1),
    this.controller,
  }) : super(key: key);

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late ScrollController _controller = widget.controller ?? ScrollController();

  double _maxWidth = 0.0;

  late double _size;
  late double _prevSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != _maxWidth) {
          _maxWidth = constraints.maxWidth;
          _size = _maxWidth / widget.initialPerRow;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _snapToGrid();
          });
        }
        return GestureDetector(
          child: _buildListView(),
          onScaleStart: (details) {
            _controller.jumpTo(0);
            _prevSize = _size;
          },
          onScaleUpdate: (details) {
            final maxSize = _maxWidth / widget.minPerRow;
            final minSize = _maxWidth / widget.maxPerRow;
            setState(() {
              _size = (_prevSize * details.scale).clamp(minSize, maxSize);
            });
          },
          onScaleEnd: (details) => _snapToGrid(),
        );
      },
    );
  }

  _snapToGrid() {
    // round 四舍五入
    final countPerRow = (_maxWidth / _size).round().clamp(widget.minPerRow, widget.maxPerRow);
    setState(() {
      _size = _maxWidth / countPerRow;
    });
  }

  ListView _buildListView() {
    final countPerRow = (_maxWidth / _size).ceil(); // ceil向上取整
    return ListView.builder(
      controller: _controller,
      itemExtent: _size,
      itemCount: widget.itemCount != null ? (widget.itemCount! / countPerRow).ceil() : null,
      itemBuilder: (context, index) {
        return OverflowBox(
          maxWidth: double.infinity,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              for (int j = 0; j < countPerRow; j++)
                if (widget.itemCount == null || index * countPerRow + j < widget.itemCount!)
                  _buildItem(context, index * countPerRow + 1),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(context, index) {
    return SizedBox(
      width: _size,
      height: _size,
      child: AnimatedSwitcher(
        duration: widget.duration,
        child: KeyedSubtree(
          // 给一个Child 增加一个Key
          key: ValueKey(index),
          child: widget.itemBuilder(context, index),
        ),
      ),
    );
  }
}
