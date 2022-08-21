import 'dart:async';

import 'package:flutter/material.dart';
import 'package:svran_flutter_study/tb/model/app_data.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/pages/apk_list_page.dart';

MapEntry<String, List<PropertiesModel>>? _item;
int? _index;

clearCacheItemIndex() {
  _item = null;
  _index = null;
}

buildTbList(or, FutureOr<void> Function() fa) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        flex: 1,
        child: ListView.separated(
          itemBuilder: (context, index) {
            var item = tbFileList[index];
            var size = dataGetTotalSize(item.value);
            var itemTitle = "${item.value[0].app_gui_label}\n${item.value[0].packageName}";
            return ListTile(
              leading: item.value[0].iconWidget,
              title: Text(itemTitle),
              subtitle: (size <= 0)
                  ? const Text('备份已删除(仅剩下信息文件)')
                  : Text("有${item.value.length}个数据备份 , 总大小 ${sizeToStr(size)}"),
              onTap: () {
                if (Orientation.landscape == or) {
                  _item = item;
                  _index = index;
                  fa.call();
                } else {
                  clearCacheItemIndex();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return SvranTbApkListPage(propertiesList: item.value, tbFileListIndex: index, fa: null);
                  })).whenComplete(fa);
                }
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemCount: tbFileList.length,
        ),
      ),
      if (Orientation.landscape == or && _item != null && _index != null)
        Expanded(
          flex: 1,
          child: SvranTbApkListPage(
            propertiesList: _item!.value,
            tbFileListIndex: _index!,
            fa: () {
              fa.call();
            },
          ),
        )
    ],
  );
}
