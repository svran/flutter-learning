import 'dart:core';

import 'package:flutter/material.dart';
import 'package:svran_flutter_study/app/ui/pages/favor/favor.dart';
import 'package:svran_flutter_study/app/ui/pages/home/home.dart';

final List<Widget> pages = [
  SvranHomeScreen(),
  SvranFavorScreen(),
];
final List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(label: "首页", icon: Icon(Icons.home)),
  const BottomNavigationBarItem(label: "收藏", icon: Icon(Icons.star)),
];
