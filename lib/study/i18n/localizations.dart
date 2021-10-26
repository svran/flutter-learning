import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SvranI18nDemoLocalizations {
  final Locale locale;

  SvranI18nDemoLocalizations(this.locale);

  static of(BuildContext context) {
    return Localizations.of(context, SvranI18nDemoLocalizations);
  }

  static Map<String, Map<String, String>> _localValue = {};

  loadJson() async {
    final jsonString = await rootBundle.loadString("assets/json/i18n.json");
    Map<String, dynamic> map = json.decode(jsonString);
    _localValue = map.map((key, value) => MapEntry(key, value.cast<String, String>()));
  }

  /*
  static final Map<String, Map<String, String>> _localValue = {
    "en": {
      "title": "Home",
      "hello": "Hello~ Word!",
      "pickTime": "Pick a time !",
    },
    "zh": {
      "title": "Home",
      "hello": "Hello~ Word!",
      "pickTime": "Pick a time !",
    },
    "jp": {
      "title": "ホーム",
      "hello": "こんにちは~ 世界!",
      "pickTime": "時間を選べください !",
    },
  }; // */

  get title {
    return _localValue[locale.languageCode]?["title"];
  }

  get hello {
    return _localValue[locale.languageCode]?["hello"];
  }

  get pickTime {
    return _localValue[locale.languageCode]?["pickTime"];
  }
}
