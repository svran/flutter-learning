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
import 'package:svran_flutter_study/third/three_d/banner_page.dart';
import 'package:svran_flutter_study/third/video/k_p.dart';
import 'package:svran_flutter_study/ws/main.dart';

import '../third/video/player_vlc.dart';
import 'async/async_demo.dart';
import 'gesture/gesture_page.dart';
import 'http_dio/http_dio_demo.dart';
import 'inherited_widget/inherited_widget_page.dart';
import 'layout/layout.dart';

final List<SvranListBean> data = [
  SvranListBean("???????????? >> ??????WSBT", const WsApp()),
  SvranListBean("?????? KP", const KaPlayer()),
  SvranListBean("??????VLC", const VlcDemo()),
  SvranListBean("????????????????????? >>", const TbListPage()),
  SvranListBean("??????????????? ?????? Boom! ??????", const SvranBoomMainPage()),
  SvranListBean("??????????????? ?????? Boom! ?????? Canvas", const SvranBoomCanvasPage()),
  SvranListBean("??????", const SvranBloodBarDemoPage()),
  SvranListBean("?????? >>", const BannerPage()),
  SvranListBean("hyu1996 conf", Scaffold(body: ObjectDefView())),
  SvranListBean("???????????? MethodChannel", const SvranMethodChannel()),
  SvranListBean("???????????????", const SvranI18nDemoPage()),
  SvranListBean("??????APP >>", const app.App()),
  SvranListBean("????????????", const ScreenAdaptationPage()),
  SvranListBean("??????", const SvranThemeDemoPage()),
  SvranListBean("Hero??????", const HeroAnimDemoPage()),
  SvranListBean("????????????", const SvranAnimDemoPage()),
  SvranListBean("?????? AnimatedBuilder", const AnimBuilderDemoPage()),
  SvranListBean("?????? AnimatedWidget", const AnimDemoPage()),
  SvranListBean("?????? Router", const RouterDemoPage()),
  SvranListBean("???????????? Event_Bus", const EventBusDemoPage()),
  SvranListBean("????????????", const GestureDemoPage()),
  SvranListBean("???????????? Provider02", const ProviderPage02()),
  SvranListBean("???????????? Provider", const ProviderPage()),
  SvranListBean("???????????? InheritedWidget", const InheritedWidgetPage()),
  SvranListBean("??????????????????", const SvranMainPage()),
  SvranListBean("???????????? Dio", const HttpDioPage()),
  SvranListBean("??????", const AsynchronousPage()),
  SvranListBean("????????????", const ScrollViewListenPage()),
  SvranListBean("?????????????????????CustomSliverView", const CustomSliverViewPage()),
  SvranListBean("????????????GridView", const GridViewPage()),
  SvranListBean("????????????ListView", const ListViewPage()),
  SvranListBean("??????", const MyLayoutHomePage()),
  SvranListBean("????????????", const MyHomePage()),
];
