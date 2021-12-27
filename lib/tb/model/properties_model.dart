import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/tb/properties.dart';

import '../../public_code.dart';

class PropertiesModel {
  String? _app_gui_label;
  String? _app_label;
  String? _app_is_forward_locked;
  String? _app_version_code;
  String? _app_version_name;
  String? _app_apk_name;
  String? _app_apk_codec;
  String? _app_apk_md5;
  String? _app_gui_icon;
  String? _app_is_system;
  String? _app_apk_location;
  XFile file;
  late String dir;

  PropertiesModel(this.file, Properties properties) {
    final p = file.path.split("\\")..removeLast();
    dir = p.join("\\");
    _app_apk_location = properties["app_apk_location"];
    _app_is_system = properties["app_is_system"];
    _app_gui_icon = properties["app_gui_icon"]?.replaceAll("\\", "=");
    _app_apk_md5 = properties["app_apk_md5"];
    _app_apk_codec = properties["app_apk_codec"];
    _app_apk_name = properties["app_apk_name"];
    _app_version_name = properties["app_version_name"];
    _app_version_code = properties["app_version_code"];
    _app_is_forward_locked = properties["app_is_forward_locked"];
    _app_label = properties["app_label"]?.replaceAllMapped(RegExp("([\\w]+)|(\\\\u([\\w]{4}))"), (match) {
      if (match.group(0)?.startsWith("\\u") == true) {
        return String.fromCharCode(_hexToInt(match.group(0).toString().replaceAll("\\u", "")));
      }
      return match.group(0).toString();
    });
    _app_gui_label = properties["app_gui_label"]?.replaceAllMapped(RegExp("([\\w]+)|(\\\\u([\\w]{4}))"), (match) {
      if (match.group(0)?.startsWith("\\u") == true) {
        return String.fromCharCode(_hexToInt(match.group(0).toString().replaceAll("\\u", "")));
      }
      return match.group(0).toString();
    });
    _extData();
  }

  String packageName = "";
  String date = "";
  String time = "";
  Widget iconWidget = const Icon(Icons.android, size: 50);
  File propertiesFile = File("");
  File dataFile = File("");
  File apkFile = File("");
  int apkSize = 0;
  int dataSize = 0;
  int totalSize = 0;

  void _extData() {
    final path = file.path;
    String fileName = path.split("\\").last;
    String fileLast = fileName.split("-").last;
    List<String> fileNameSplit = fileName.split("-");
    packageName = fileNameSplit.first;
    date = fileNameSplit[1];
    time = fileNameSplit.last.split(".").first;
    // logger.d("Svran: Flutter -> path: ${file.path}");
    // logger.d("Svran: Flutter -> fileName:$fileName");
    // logger.d("Svran: Flutter -> fileLast:$fileLast");
    // logger.d("Svran: Flutter -> package:$package");
    // logger.d("Svran: Flutter -> date:$date");
    // logger.d("Svran: Flutter -> time:$time");
    iconWidget = app_gui_icon == null ? const Icon(Icons.android, size: 50) : Image.memory(base64Decode(app_gui_icon!));
    propertiesFile = File(path);
    dataFile = File(path.replaceAll(".properties", ".tar.gz"));
    apkFile = File("$dir\\$packageName-$app_apk_md5.apk.gz");
    apkSize = apkFile.existsSync() ? apkFile.lengthSync() : 0;
    dataSize = dataFile.existsSync() ? dataFile.lengthSync() : 0;
    totalSize = apkSize + dataSize;
  }

  String apkSizeStr() => _sizeStr(apkSize);

  String dataSizeStr() => _sizeStr(dataSize);

  String totalSizeStr() => _sizeStr(totalSize);

  String _sizeStr(int size) {
    if (size <= 0) {
      return "/";
    } else if (size >= 0 && size < 1024) {
      return "${size}B";
    } else if (size > 1024 && size < 1024 * 1024) {
      return "${size ~/ 1024}KB";
    } else if (size > (1024 * 1024) && size < 1024 * 1024 * 1024) {
      return "${size / 1024 ~/ 1024}MB";
    } else {
      return "${size / 1024 / 1024 ~/ 1024}GB";
    }
  }

  bool contains(String nameOrPackage) {
    return nameOrPackage.isEmpty || packageName.contains(nameOrPackage) || (app_label).contains(nameOrPackage);
  }

  int _hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  @override
  String toString() {
    return 'PropertiesModel{_app_gui_label: $_app_gui_label, _app_label: $_app_label, _app_is_forward_locked: $_app_is_forward_locked, _app_version_code: $_app_version_code, _app_version_name: $_app_version_name, _app_apk_name: $_app_apk_name, _app_apk_codec: $_app_apk_codec, _app_apk_md5: $_app_apk_md5, _app_gui_icon: $_app_gui_icon, _app_is_system: $_app_is_system, _app_apk_location: $_app_apk_location}';
  }

  String get app_gui_label => _app_gui_label ?? "<ERROR>";

  String get app_label => _app_label ?? "<ERROR>";

  bool get isLock => (_app_is_forward_locked ?? "0") == "1";

  String get app_version_code => _app_version_code ?? "";

  String get app_version_name => _app_version_name ?? "";

  String get app_apk_name => _app_apk_name ?? "";

  String get app_apk_codec => _app_apk_codec ?? "";

  String get app_apk_md5 => _app_apk_md5 ?? "";

  String? get app_gui_icon => _app_gui_icon;

  bool get isSys => (_app_is_system ?? "0") == "1";

  String get app_apk_location => _app_apk_location ?? "";
}
