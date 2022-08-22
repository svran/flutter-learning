import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/extensions/relative_rect.dart';
import 'package:svran_flutter_study/tb/model/app_data.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/pages/key_test.dart';
import 'package:svran_flutter_study/tb/pages/widget/tb_list.dart';
import 'package:svran_flutter_study/tb/properties.dart';
import 'package:svran_flutter_study/tb/widget/progress_dialog.dart';

import '../../boom/widget/boom_widget.dart';
import '../../public_code.dart';

class TbListPage extends StatefulWidget {
  const TbListPage({Key? key}) : super(key: key);

  @override
  State<TbListPage> createState() => _TbListPageState();
}

class _TbListPageState extends State<TbListPage> {
  String? dir = "选个路径呗 ->";
  TextEditingController input = TextEditingController();
  int sort = 0;

  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      return;
    }
    final key = event.data.logicalKey;
    if (key == LogicalKeyboardKey.escape && Navigator.canPop(context)) {
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
    Offset offset = Offset.zero;
    return Scaffold(
      appBar: AppBar(
        title: const Text("备份"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => KeyTest(title: "关于")));
            },
            icon: const Icon(Icons.info_outline),
          ),
          MouseRegion(
            onHover: (event) {
              offset = event.position;
            },
            child: IconButton(
                onPressed: () {
                  showMenu(
                    context: context,
                    position: RelativeRectExt.fromOffsetExt(offset),
                    items: [
                      PopupMenuItem(
                        enabled: sort != 0,
                        child: const Text('默认(包名排序)'),
                        onTap: () {
                          sort = 0;
                          clearCacheItemIndex();
                          openFile(sort: sort, refresh: true);
                        },
                      ),
                      PopupMenuItem(
                        enabled: sort != 1,
                        child: const Text('备份总大小-降序'),
                        onTap: () {
                          sort = 1;
                          clearCacheItemIndex();
                          openFile(sort: sort, refresh: true);
                        },
                      ),
                      PopupMenuItem(
                        enabled: sort != 2,
                        child: const Text('备份总大小-升序'),
                        onTap: () {
                          sort = 2;
                          clearCacheItemIndex();
                          openFile(sort: sort, refresh: true);
                        },
                      ),
                      PopupMenuItem(
                        enabled: sort != 3,
                        child: const Text('备份数量-降序'),
                        onTap: () {
                          sort = 3;
                          clearCacheItemIndex();
                          openFile(sort: sort, refresh: true);
                        },
                      ),
                      PopupMenuItem(
                        enabled: sort != 4,
                        child: const Text('备份数量-升序'),
                        onTap: () {
                          sort = 4;
                          clearCacheItemIndex();
                          openFile(sort: sort, refresh: true);
                        },
                      ),
                    ],
                  );
                },
                icon: const Icon(Icons.sort)),
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
                  ElevatedButton(
                      onPressed: () {
                        clearCacheItemIndex();
                        openFile(sort: sort);
                      },
                      child: const Text('选择')),
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
                  ElevatedButton(
                      onPressed: () {
                        clearCacheItemIndex();
                        openFile(refresh: true, sort: sort);
                      },
                      child: const Text('过滤')),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.blue),
            Expanded(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return buildTbList(orientation, () => setState(() {}));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  openFile({int sort = 0, bool refresh = false}) async {
    if (refresh) {
      loadFiles(refresh: refresh, sortType: sort, input: input);
      return;
    }
    await Dialogs.showNormalProgressDialog(context, '加载中，请稍后。。。', () async {
      loadFiles(refresh: refresh, sortType: sort, input: input);
    });
  }

  loadFiles({required TextEditingController input, required int sortType, bool refresh = false}) async {
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
      switch (sortType) {
        case 4:
        case 3:
          tbFileList.sort((a, b) {
            var aa = 0;
            var bb = 0;
            for (var i = 0; i < a.value.length; ++i) {
              var item = a.value[i];
              // 确定当前配置下,存在备份apk或者备份数据,才备份数量增加1
              if (item.dataFile.existsSync() || item.apkFile.existsSync()) aa++;
            }
            for (var i = 0; i < b.value.length; ++i) {
              var item = b.value[i];
              if (item.dataFile.existsSync() || item.apkFile.existsSync()) bb++;
            }
            if (sortType == 3) {
              return bb.compareTo(aa);
            } else {
              return aa.compareTo(bb);
            }
          });
          break;
        case 2: // 总大小排序,1 降序 2 升序
        case 1: // 总大小排序,1 降序 2 升序
          tbFileList.sort((a, b) {
            List<PropertiesModel> ap = a.value;
            List<PropertiesModel> bp = b.value;
            var aSize = dataGetTotalSize(ap);
            var bSize = dataGetTotalSize(bp);
            if (sortType == 1) {
              return bSize.compareTo(aSize);
            } else {
              return aSize.compareTo(bSize);
            }
          });
          break;
        default:
          logger.d("默认排序");
      }
      setState(() {});
    } catch (error) {
      if (error.runtimeType == FileSystemException) {
        svranToast('选个路径嘛!');
        return;
      }
      svranToast("错误:$error");
    }
  }
}
