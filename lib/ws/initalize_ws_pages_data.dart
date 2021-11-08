import 'package:svran_flutter_study/beans/svran_list_bean.dart';
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
import 'package:svran_flutter_study/ws/key/k01/key01_no_key.dart';
import 'package:svran_flutter_study/ws/key/k02/local_key.dart';
import 'package:svran_flutter_study/ws/key/k03/global_key.dart';

final List<SvranListBean> wsData = [
  // key 相关
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
