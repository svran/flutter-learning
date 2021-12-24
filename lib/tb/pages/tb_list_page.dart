import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/properties.dart';
import 'package:svran_flutter_study/tb/widget/progress_dialog.dart';

final Map<String, List<PropertiesModel>> tbFileMap = {};
List<MapEntry<String, List<PropertiesModel>>> tbFileList = [];

class TbListPage extends StatefulWidget {
  const TbListPage({Key? key}) : super(key: key);

  @override
  State<TbListPage> createState() => _TbListPageState();
}

class _TbListPageState extends State<TbListPage> {
  String? dir = "E:\\Download\\testTb";

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
                Expanded(child: Text(dir ?? "", style: TextStyle(fontSize: 18))),
                ElevatedButton(onPressed: () => openFile(), child: Text('选择')),
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
                  onTap: () => backupFilesDialog(item.value),
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

  openFile() async {
    await Dialogs.showNormalProgressDialog(context, '加载中，请稍后。。。', () async {
      try {
        dir = await getDirectoryPath();
        if (dir != null) {
          tbFileMap.clear();
          final dirFile = Directory(dir!);
          final fileList = dirFile.listSync().where((element) => element.path.endsWith(".properties")).toList();
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
            if (!hadApp) {
              List<PropertiesModel> list = [pm];
              tbFileMap.putIfAbsent(package, () => list);
            } else {
              tbFileMap[package]?.add(pm);
            }
          }
        }
        tbFileList = tbFileMap.entries.toList();
        setState(() {});
      } catch (error) {
        svranToast("错误:$error");
      }
    });
  }

  backupFilesDialog(List<PropertiesModel> value) {
    final title = value[0].app_label ?? "<ERROR>";
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          child: Container(
            height: 300,
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
                      final item = value[index];
                      final icon = item.app_gui_icon;
                      final path = item.file.path;

                      String fileName = path.split("\\").last;
                      String fileLast = fileName.split("-").last;
                      List<String> fileNameSplit = fileName.split("-");
                      String package = fileNameSplit.first;
                      String date = fileNameSplit[1];
                      String time = fileNameSplit.last.split(".").first;

                      final dataFile = XFile(fileName.replaceAll(".properties", ".tar.gz"));
                      final apkFile = XFile("$package${item.app_apk_md5}.apk.gz");
                      // final apkSize = apkFile.length();
                      // final dataSize = dataFile.length();
                      // final totalSize = apkSize + dataSize;
                      return ListTile(
                        contentPadding: EdgeInsets.all(5),
                        leading: icon == null ? Icon(Icons.android, size: 50) : Image.memory(base64Decode(icon)),
                        title: Text(item.app_gui_label ?? "<ERROR>",
                            style: TextStyle(color: item.app_is_system == true ? Colors.red : Colors.black)),
                        subtitle: Text("$date - $time"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('确认删除?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('确认'),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemCount: value.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
