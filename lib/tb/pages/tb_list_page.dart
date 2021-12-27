import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/pages/apk_list_page.dart';
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
                  return ListTile(
                    leading: item.value[0].iconWidget,
                    title: Text(item.value[0].app_gui_label),
                    subtitle: Text("有${item.value.length}个备份"),
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
