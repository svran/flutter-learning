import 'package:flutter/material.dart';
import 'package:svran_flutter_study/douban/pages/home/home.dart';
import 'package:svran_flutter_study/douban/pages/subject/subject.dart';

List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: "首页"),
  BottomNavigationBarItem(icon: Icon(Icons.subject_outlined), activeIcon: Icon(Icons.subject), label: "书影音"),
  BottomNavigationBarItem(icon: Icon(Icons.group_outlined), activeIcon: Icon(Icons.group), label: "小组"),
  BottomNavigationBarItem(icon: Icon(Icons.local_mall_outlined), activeIcon: Icon(Icons.local_mall), label: "市集"),
  BottomNavigationBarItem(icon: Icon(Icons.person_outlined), activeIcon: Icon(Icons.person), label: "我的"),
];

List<Widget> pages = [
  SvranHomePage(),
  SvranSubjectPage(),
  SvranSubjectPage(),
  SvranSubjectPage(),
  SvranSubjectPage()
];