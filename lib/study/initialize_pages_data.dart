import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/main.dart' as app;
import 'package:svran_flutter_study/beans/svran_list_bean.dart';
import 'package:svran_flutter_study/boom/boom_canvas.dart';
import 'package:svran_flutter_study/boom/boom_main.dart';
import 'package:svran_flutter_study/douban/pages/main/main.dart';
import 'package:svran_flutter_study/first/my_home_page.dart';
import 'package:svran_flutter_study/hyu1996/object_def_view.dart';
import 'package:svran_flutter_study/study/animation/anim_builder_page.dart';
import 'package:svran_flutter_study/study/animation/anim_page.dart';
import 'package:svran_flutter_study/study/animation/hero_anim_page.dart';
import 'package:svran_flutter_study/study/animation/svran_anim_page.dart';
import 'package:svran_flutter_study/study/blood/blood_bar.dart';
import 'package:svran_flutter_study/study/event_bus/event_bus_page.dart';
import 'package:svran_flutter_study/study/i18n/i18n_demo_page.dart';
import 'package:svran_flutter_study/study/platform/method_channel.dart';
import 'package:svran_flutter_study/study/provider/provider_page.dart';
import 'package:svran_flutter_study/study/provider/provider_page02.dart';
import 'package:svran_flutter_study/study/router/route_demo_page.dart';
import 'package:svran_flutter_study/study/screen_adaptation/svran_screen_adaptation.dart';
import 'package:svran_flutter_study/study/scroll_widget/custom_sliver_view_demo.dart';
import 'package:svran_flutter_study/study/scroll_widget/grid_view_demo.dart';
import 'package:svran_flutter_study/study/scroll_widget/list_view_demo.dart';
import 'package:svran_flutter_study/study/scroll_widget/scroll_view_listen_demo.dart';
import 'package:svran_flutter_study/study/theme/theme_page.dart';
import 'package:svran_flutter_study/tb/pages/tb_list_page.dart';
import 'package:svran_flutter_study/ws/main.dart';

import 'async/async_demo.dart';
import 'gesture/gesture_page.dart';
import 'http_dio/http_dio_demo.dart';
import 'inherited_widget/inherited_widget_page.dart';
import 'layout/layout.dart';

final List<SvranListBean> data = [
  SvranListBean("新的学习 >> 补充WSBT", const WsApp()),
  SvranListBean("管理钛备份文件 >>", const TbListPage()),
  SvranListBean("好玩的效果 点击 Boom! 炸开", const SvranBoomMainPage()),
  SvranListBean("好玩的效果 点击 Boom! 炸开 Canvas", const SvranBoomCanvasPage()),
  SvranListBean("血条", const SvranBloodBarDemoPage()),
  SvranListBean("hyu1996 conf", Scaffold(body: ObjectDefView())),
  SvranListBean("原生插件 MethodChannel", const SvranMethodChannel()),
  SvranListBean("国际化适配", const SvranI18nDemoPage()),
  SvranListBean("练手APP >>", const app.App()),
  SvranListBean("屏幕适配", const ScreenAdaptationPage()),
  SvranListBean("主题", const SvranThemeDemoPage()),
  SvranListBean("Hero动画", const HeroAnimDemoPage()),
  SvranListBean("交织动画", const SvranAnimDemoPage()),
  SvranListBean("动画 AnimatedBuilder", const AnimBuilderDemoPage()),
  SvranListBean("动画 AnimatedWidget", const AnimDemoPage()),
  SvranListBean("路由 Router", const RouterDemoPage()),
  SvranListBean("事件总线 Event_Bus", const EventBusDemoPage()),
  SvranListBean("事件监听", const GestureDemoPage()),
  SvranListBean("状态管理 Provider02", const ProviderPage02()),
  SvranListBean("状态管理 Provider", const ProviderPage()),
  SvranListBean("状态管理 InheritedWidget", const InheritedWidgetPage()),
  SvranListBean("练习布局豆瓣", const SvranMainPage()),
  SvranListBean("网络请求 Dio", const HttpDioPage()),
  SvranListBean("异步", const AsynchronousPage()),
  SvranListBean("滚动监听", const ScrollViewListenPage()),
  SvranListBean("自定义滚动控件CustomSliverView", const CustomSliverViewPage()),
  SvranListBean("滚动控件GridView", const GridViewPage()),
  SvranListBean("滚动控件ListView", const ListViewPage()),
  SvranListBean("布局", const MyLayoutHomePage()),
  SvranListBean("首次学习", const MyHomePage()),
];
