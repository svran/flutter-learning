import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/study/i18n/localizations.dart';

class SvranLocalizationsDelegate extends LocalizationsDelegate<SvranI18nDemoLocalizations> {
  static SvranLocalizationsDelegate delegate = SvranLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // 是否支持某些语言
    return ["zh", "en", "jp"].contains(locale.languageCode);
  }

  @override
  Future<SvranI18nDemoLocalizations> load(Locale locale) async {
    // 这里返回 异步加载的语言数据.
    // 我这Demo中是 固定的数据, 可以直接返回同步数据.
    // return SynchronousFuture(SvranI18nDemoLocalizations(locale));

    // 如果是远程数据, 可以直接返回一个 Future
    // 拿json文件加载举例:
    final l = SvranI18nDemoLocalizations(locale);
    await l.loadJson();
    return l;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<SvranI18nDemoLocalizations> old) {
    // 当重新build的时候,是否需要重新加载语言配置?
    // 一般情况下,是不需要的. 官方数据中也基本上返回的false;
    return false;
  }
}
