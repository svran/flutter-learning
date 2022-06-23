import 'package:svran_flutter_study/beans/svran_list_bean.dart';
import 'package:svran_flutter_study/ws/act/act_countdown_button.dart';
import 'package:svran_flutter_study/ws/act/act_gallery_view.dart';
import 'package:svran_flutter_study/ws/act/act_highly_used_widgets.dart';
import 'package:svran_flutter_study/ws/act/act_hollowed_text.dart';
import 'package:svran_flutter_study/ws/act/act_lnk_lnk_well_material.dart';
import 'package:svran_flutter_study/ws/act/act_unpopular_widget.dart';
import 'package:svran_flutter_study/ws/act/act_water_mark.dart';
import 'package:svran_flutter_study/ws/act/act_will_pop_scope.dart';
import 'package:svran_flutter_study/ws/anim/a01/animated_widget.dart';
import 'package:svran_flutter_study/ws/anim/a02/animated_switcher.dart';
import 'package:svran_flutter_study/ws/anim/a03/animated_number.dart';
import 'package:svran_flutter_study/ws/anim/a04/animated_number.dart';
import 'package:svran_flutter_study/ws/anim/a05/tween_anim.dart';
import 'package:svran_flutter_study/ws/anim/a06/anim_curves.dart';
import 'package:svran_flutter_study/ws/anim/a07/anim_unlimited.dart';
import 'package:svran_flutter_study/ws/anim/a08/anim_controller.dart';
import 'package:svran_flutter_study/ws/anim/a09/anim_controller_tween.dart';
import 'package:svran_flutter_study/ws/anim/a10/anim_a10.dart';
import 'package:svran_flutter_study/ws/anim/a11/custom_anim.dart';
import 'package:svran_flutter_study/ws/anim/a12/anim_478.dart';
import 'package:svran_flutter_study/ws/anim/a13/anim_principle.dart';
import 'package:svran_flutter_study/ws/anim/a14/anim_custom_painter.dart';
import 'package:svran_flutter_study/ws/anim/a15/board_painter.dart';
import 'package:svran_flutter_study/ws/async/a01/event_loop.dart';
import 'package:svran_flutter_study/ws/async/a02/future_builder.dart';
import 'package:svran_flutter_study/ws/async/a03/stream_and_stream_builder.dart';
import 'package:svran_flutter_study/ws/async/a04/game_stream.dart';
import 'package:svran_flutter_study/ws/key/k01/key01_no_key.dart';
import 'package:svran_flutter_study/ws/key/k02/local_key.dart';
import 'package:svran_flutter_study/ws/key/k03/global_key.dart';
import 'package:svran_flutter_study/ws/key/k04/key_color_game.dart';
import 'package:svran_flutter_study/ws/layout/render_object.dart';
import 'package:svran_flutter_study/ws/scrollable/scrollable_list.dart';
import 'package:svran_flutter_study/ws/scrollable/scrollable_widget.dart';
import 'package:svran_flutter_study/ws/slivers/s01/sliver_01.dart';
import 'package:svran_flutter_study/ws/slivers/s02/sliver_02.dart';
import 'package:svran_flutter_study/ws/slivers/s03/sliver_app_bar.dart';
import 'package:svran_flutter_study/ws/slivers/s04/sliver_04.dart';
import 'package:svran_flutter_study/ws/slivers/s05/listview_to_sliver.dart';
import 'package:svran_flutter_study/ws/slivers/s06/sliver_persistent_header.dart';
import 'package:svran_flutter_study/ws/slivers/s07/sliver_list.dart';
import 'package:svran_flutter_study/ws/supplement/supplement_01.dart';

final List<SvranListBean> wsData = [
  // 补充
  SvranListBean("补充 01 写个球 ", const ThreeDBallPage()),
  // 滚动
  SvranListBean("滚动 07 设计一个有SliverAppBar的页面 ", const SliverListInstanceDemoPage()),
  SvranListBean("滚动 06 SliverPersistentHeader的使用", const SliverPersistentHeaderSliverListDemoPage()),
  SvranListBean("滚动 05 从ListView到SliverList", const ListViewToSliverListDemoPage()),
  SvranListBean("滚动 04 更多的Sliver组件", const Slivers04DemoPage()),
  SvranListBean("滚动 03 SliverAppBar", const SliverAppBarDemoPage()),
  SvranListBean("滚动 02 其他Sliver滚动组件", const Sliver02DemoPage()),
  SvranListBean("滚动 01 滚动视窗 CustomScrollView", const Sliver01DemoPage()),
  // 其他
  SvranListBean("练习 08 冷门Flutter组件", const ActUnpopularWidgetDemoPage()),
  SvranListBean("练习 07 支持捏拉缩放手势的网格列表", const ActGalleryViewDemoPage()),
  SvranListBean("练习 06 一些使用率高的组件", const HighlyUsedWidgetDemoPage()),
  SvranListBean("练习 05 WillPopScope", const AddWillPopScopeDemoPage()),
  SvranListBean("练习 04 倒计时按钮", const ActCountdownButtonDemoPage()),
  SvranListBean("练习 03 覆盖水印效果", const ActWaterMarkDemoPage()),
  SvranListBean("练习 02 文字镂空效果", const ActHollowedTextDemoPage()),
  SvranListBean("练习 01 ActLnkLnkWellMaterial", const ActLnkLnkWellMaterialDemoPage()),
  // 布局
  SvranListBean("布局 00 RenderObject", const RenderObjectDemoPage()),
  // Async
  SvranListBean("异步 04 GameStream", const GameStreamDemoPage()),
  SvranListBean("异步 03 Stream与StreamBuilder组件", const StreamAndStreamBuilderDemoPage()),
  SvranListBean("异步 02 FutureBuilder组件", const FutureBuilderDemoPage()),
  SvranListBean("异步 01 事件循环", const EventLoopDemoPage()),
  // 滚动(Scrollable) 列表
  SvranListBean("滚动 02 其他科滚动控件", const ScrollableWidgetDemoPage()),
  SvranListBean("滚动 01 滚动列表", const ScrollableListDemoPage()),
  // key 相关
  SvranListBean("Key 04 实例Key,颜色排序游戏", const KeyColorGameDemoPage()),
  SvranListBean("Key 03 全局键 GlobalKey", const GlobalKeyDemoPage()),
  SvranListBean("Key 02 局部键 LocalKey", const SvranLocalKeyDemoPage()),
  SvranListBean("Key 01 没有Key会发生什么奇怪现象", const NoKeyDemoPage()),
  // 动画相关
  SvranListBean("动画15 白板绘制 CustomPainter", const BoardPainterDemoPage()),
  SvranListBean("动画14 直接操作底层的CustomPainter", const AminCustomPainterDemoPage()),
  SvranListBean("动画13 动画背后的原理和机制", const AminPrincipleDemoPage()),
  SvranListBean("动画12 自定义动画478呼吸法", const Anim478DemoPage()),
  SvranListBean("动画11 自定义动画", const SvranCustomAnimDemoPage()),
  SvranListBean("动画10 交错动画,管理区间,曲线", const SvranAnimA10DemoPage()),
  SvranListBean("动画09 控制器串联补间动画和曲线", const AminControllerTweenDemoPage()),
  SvranListBean("动画08 动画控制器", const AnimControllerDemoPage()),
  SvranListBean("动画07 无尽旋转的显式动画", const AnimatedUnlimitedDemoPage()),
  SvranListBean("动画06 更多动画控制以及曲线", const CurvesDemoPage()),
  SvranListBean("动画05 补间动画", const TweenAnimBuilderDemoPage()),
  SvranListBean("动画04 翻滚计数器2", const AnimatedNumberDemoPage1()),
  SvranListBean("动画03 翻滚计数器", const AnimatedNumberDemoPage()),
  SvranListBean("动画02 AnimatedSwitcher", const AnimatedSwitcherDemoPage()),
  SvranListBean("动画01 AnimatedXXX", const AnimatedWidgetDemoPage()),
];
