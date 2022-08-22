import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/public_code.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/properties.dart';

final Map<String, List<PropertiesModel>> tbFileMap = {};
List<MapEntry<String, List<PropertiesModel>>> tbFileList = [];

void dataRemoveAt(int index) {}

int dataGetTotalSize(List<PropertiesModel> list) {
  var size = 0;
  var lastApkName = "";
  for (var i = 0; i < list.length; ++i) {
    if (lastApkName != list[i].app_apk_md5) {
      size = list[i].apkSize;
      lastApkName = list[i].app_apk_md5;
    }
    size += list[i].dataSize;
  }
  return size;
}


String sizeToStr(int limit) {
  if (limit <= 0) return "❌";
  //内存转换
  if (limit < 1 * 1024) {
    //小于0.1KB，则转化成B
    var size = limit.toStringAsFixed(2);
    return "$size B";
  } else if (limit < 1 * 1024 * 1024) {
    //小于0.1MB，则转化成KB
    var size = (limit / 1024).toStringAsFixed(2);
    return "$size KB";
  } else if (limit < 1 * 1024 * 1024 * 1024) {
    //小于0.1GB，则转化成MB
    var size = (limit / (1024 * 1024)).toStringAsFixed(2);
    return "$size MB";
  } else {
    //其他转化成GB
    var size = (limit / (1024 * 1024 * 1024)).toStringAsFixed(2);
    return "$size GB";
  }
}
