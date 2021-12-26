import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/properties.dart';
import 'package:svran_flutter_study/tb/widget/progress_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("备份"),
      ),
      body: Column(
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
                    decoration: InputDecoration(hintText: " 包名或者app名"),
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
                final icon = item.value[0].app_gui_icon;
                final title = item.value[0].app_gui_label;
                return ListTile(
                  leading: icon == null ? const Icon(Icons.android, size: 50) : Image.memory(base64Decode(icon)),
                  title: Text(title ?? "<ERROR>"),
                  subtitle: Text("有${item.value.length}个备份"),
                  onTap: () => backupFilesDialog(item.value, index),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemCount: tbFileList.length,
            ),
          ),
        ],
      ),
    );
  }

  openFile({bool refresh = false}) async {
    if (refresh) {
      loadFiles(refresh: refresh);
      svranToast("加载完毕!");
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
          final path = file.path;
          String fileName = path.split("\\").last;
          String fileLast = fileName.split("-").last;
          List<String> fileNameSplit = fileName.split("-");
          String package = fileNameSplit.first;
          String date = fileNameSplit[1];
          String time = fileNameSplit.last.split(".").first;
          // logger.d("Svran: Flutter -> path: ${file.path}");
          // logger.d("Svran: Flutter -> fileName:$fileName");
          // logger.d("Svran: Flutter -> fileLast:$fileLast");
          // logger.d("Svran: Flutter -> package:$package");
          // logger.d("Svran: Flutter -> date:$date");
          // logger.d("Svran: Flutter -> time:$time");

          final hadApp = tbFileMap.containsKey(package);
          final tmpFile = XFile(file.path);
          PropertiesModel pm = PropertiesModel(tmpFile, Properties.loadString(await tmpFile.readAsString()));
          if (input.text.isEmpty || package.contains(input.text) || (pm.app_label ?? "<ERROR>").contains(input.text)) {
            if (!hadApp) {
              List<PropertiesModel> list = [pm];
              tbFileMap.putIfAbsent(package, () => list);
            } else {
              tbFileMap[package]?.add(pm);
            }
          }
        }
      }
      tbFileList = tbFileMap.entries.toList();
      setState(() {});
    } catch (error) {
      svranToast("错误:$error");
    }
  }

  backupFilesDialog(List<PropertiesModel> propertiesList, int tbFileListIndex) {
    final title = propertiesList[0].app_label ?? "<ERROR>";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state) {
            return CustomDialog(
              child: Container(
                height: 400,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(child: Text(title, style: const TextStyle(fontSize: 20))),
                      const CloseButton(),
                    ]),
                    const Divider(height: 1, color: Colors.blue),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final item = propertiesList[index];
                          final icon = item.app_gui_icon;
                          final path = item.file.path;

                          String fileName = path.split("\\").last;
                          String fileLast = fileName.split("-").last;
                          List<String> fileNameSplit = fileName.split("-");
                          String package = fileNameSplit.first;
                          String date = fileNameSplit[1];
                          String time = fileNameSplit.last.split(".").first;

                          final propertiesFile = File(path);
                          final dataFile = File("$dir\\${fileName.replaceAll(".properties", ".tar.gz")}");
                          final apkFile = File("$dir\\$package-${item.app_apk_md5}.apk.gz");
                          final apkSize = apkFile.existsSync() ? apkFile.lengthSync() : 0;
                          final dataSize = dataFile.existsSync() ? dataFile.lengthSync() : 0;
                          final totalSize = apkSize + dataSize;
                          String apkSizeStr = sizeStr(apkSize);
                          String dataSizeStr = sizeStr(dataSize);
                          String totalSizeStr = sizeStr(totalSize);

                          final list = propertiesList.where((element) => element.app_apk_md5 == item.app_apk_md5);
                          bool canDelAPk = list.length <= 1;

                          bool isLock = "1" == item.app_is_forward_locked;
                          bool isSys = "1" == item.app_is_system;

                          return ListTile(
                            tileColor: isSys ? Colors.red.withOpacity(0.5) : Colors.white,
                            contentPadding: const EdgeInsets.all(5),
                            leading:
                                icon == null ? const Icon(Icons.android, size: 50) : Image.memory(base64Decode(icon)),
                            title: Text(item.app_gui_label ?? "<ERROR>",
                                style: TextStyle(color: isLock ? Colors.orange : Colors.black)),
                            subtitle: Text("$date - $time\nAPP:$apkSizeStr　DATA:$dataSizeStr　总:$totalSizeStr"),
                            trailing: IconButton(
                              icon: Icon(isLock ? Icons.lock : (canDelAPk ? Icons.delete_forever : Icons.delete)),
                              onPressed: () {
                                deleteDialog().then((dv) {
                                  if (dv == true) {
                                    if (dataFile.existsSync()) dataFile.deleteSync();
                                    if (canDelAPk && apkFile.existsSync()) apkFile.deleteSync();
                                    if (propertiesFile.existsSync()) propertiesFile.deleteSync();
                                    propertiesList.removeAt(index);
                                    if (propertiesList.isEmpty) {
                                      svranToast("已删除完");
                                      tbFileList.removeAt(tbFileListIndex);
                                      Navigator.pop(context);
                                    } else {
                                      state(() {});
                                    }
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemCount: propertiesList.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String sizeStr(int size) {
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

  Future<bool?> deleteDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('确认', style: TextStyle(color: Colors.red)),
          )
        ],
      ),
    );
  }
}
