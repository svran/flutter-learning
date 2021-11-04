import 'package:svran_flutter_study/beans/svran_list_bean.dart';
import 'package:svran_flutter_study/ws/anim/a01/animated_widget.dart';
import 'package:svran_flutter_study/ws/anim/a02/animated_switcher.dart';
import 'package:svran_flutter_study/ws/anim/a03/animated_number.dart';
import 'package:svran_flutter_study/ws/anim/a04/animated_number.dart';
import 'package:svran_flutter_study/ws/anim/a05/tween_anim.dart';
import 'package:svran_flutter_study/ws/anim/a06/anim_curves.dart';

final List<SvranListBean> wsData = [
  SvranListBean("动画 AnimatedXXX", const AnimatedWidgetDemoPage()),
  SvranListBean("动画 AnimatedSwitcher", const AnimatedSwitcherDemoPage()),
  SvranListBean("动画 翻滚计数器", const AnimatedNumberDemoPage()),
  SvranListBean("动画 翻滚计数器2", const AnimatedNumberDemoPage1()),
  SvranListBean("动画 补间动画", const TweenAnimBuilderDemoPage()),
  SvranListBean("动画 更多动画控制以及曲线", const CurvesDemoPage()),
];
