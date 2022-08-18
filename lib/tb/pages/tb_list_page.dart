import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/pages/apk_list_page.dart';
import 'package:svran_flutter_study/tb/pages/key_test.dart';
import 'package:svran_flutter_study/tb/properties.dart';
import 'package:svran_flutter_study/tb/widget/progress_dialog.dart';

import '../../boom/widget/boom_widget.dart';
import '../../public_code.dart';

final Map<String, List<PropertiesModel>> tbFileMap = {};
List<MapEntry<String, List<PropertiesModel>>> tbFileList = [];

class TbListPage extends StatefulWidget {
  const TbListPage({Key? key}) : super(key: key);

  @override
  State<TbListPage> createState() => _TbListPageState();
}

class _TbListPageState extends State<TbListPage> {
  String? dir = "选个路径呗 ->";
  TextEditingController input = TextEditingController();

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      return;
    }
    final key = event.data.logicalKey;
    if (key == LogicalKeyboardKey.escape && Navigator.canPop(context)) {
      logger.d("Svran: Flutter -> 啊啊");
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    RawKeyboard.instance.addListener(_onKey);
    super.initState();
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_onKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("备份"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => KeyTest(title: "按键测试")));
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: SvranClickBoomWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text(dir ?? "", style: const TextStyle(fontSize: 18))),
                  ElevatedButton(onPressed: () => openFile(), child: const Text('选择')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: input,
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(hintText: " 包名或者app名"),
                    ),
                  ),
                  ElevatedButton(onPressed: () => openFile(refresh: true), child: const Text('过滤')),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.blue),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final item = tbFileList[index];
                  var size = getTotalSize(item.value);
                  return ListTile(
                    leading: item.value[0].iconWidget,
                    title: Text(item.value[0].app_gui_label),
                    subtitle: (size <= 0)
                        ? const Text('备份已删除(仅剩下信息文件)')
                        : Text("有${item.value.length}个数据备份 , 总大小 ${_sizeStr(size)}"),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return SvranTbApkListPage(propertiesList: item.value, tbFileListIndex: index);
                      })).whenComplete(() => setState(() {}));
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemCount: tbFileList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _sizeStr(int limit) {
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

  openFile({bool refresh = false}) async {
    if (refresh) {
      loadFiles(refresh: refresh);
      return;
    }
    await Dialogs.showNormalProgressDialog(context, '加载中，请稍后。。。', () async {
      loadFiles();
    });
  }

  loadFiles({bool refresh = false}) async {
    try {
      if (!refresh) dir = await getDirectoryPath() ?? dir;
      if (dir != null) {
        tbFileMap.clear();
        final dirFile = Directory(dir!);
        final fileList = dirFile.listSync().where((element) => element.path.endsWith(".properties")).toList();
        logger.d("Svran: Flutter -> 过滤文字:${input.text}");
        for (FileSystemEntity file in fileList) {
          final tmpFile = XFile(file.path);
          PropertiesModel pm = PropertiesModel(tmpFile, Properties.loadString(await tmpFile.readAsString()));
          final hadApp = tbFileMap.containsKey(pm.packageName);
          if (pm.contains(input.text)) {
            if (!hadApp) {
              List<PropertiesModel> list = [pm];
              tbFileMap.putIfAbsent(pm.packageName, () => list);
            } else {
              tbFileMap[pm.packageName]?.add(pm);
            }
          }
        }
      }
      tbFileList = tbFileMap.entries.toList();
      tbFileList.sort((a, b) {
        List<PropertiesModel> ap = a.value;
        List<PropertiesModel> bp = b.value;
        var aSize = getTotalSize(ap);
        var bSize = getTotalSize(bp);
        return bSize.compareTo(aSize);
      });
      setState(() {});
    } catch (error) {
      if (error.runtimeType == FileSystemException) {
        svranToast('选个路径嘛!');
        return;
      }
      svranToast("错误:$error");
    }
  }

  int getTotalSize(List<PropertiesModel> list) {
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
}
