import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/boom/widget/boom_widget.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
import 'package:svran_flutter_study/extensions/relative_rect.dart';
import 'package:svran_flutter_study/tb/model/properties_model.dart';
import 'package:svran_flutter_study/tb/pages/tb_list_page.dart';

class SvranTbApkListPage extends StatefulWidget {
  static const String routeName = "/SvranTbApkListPage";
  final List<PropertiesModel> propertiesList;
  final int tbFileListIndex;

  const SvranTbApkListPage({Key? key, required this.propertiesList, required this.tbFileListIndex}) : super(key: key);

  @override
  State<SvranTbApkListPage> createState() => _SvranTbApkListPageState();
}

class _SvranTbApkListPageState extends State<SvranTbApkListPage> {
  Offset offset = Offset.zero;

  _onKey(RawKeyEvent event) {
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
    final title = widget.propertiesList.isNotEmpty ? widget.propertiesList[0].app_label : "已删除";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SvranClickBoomWidget(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return dialogBakItem(widget.propertiesList, index, widget.tbFileListIndex);
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: widget.propertiesList.length,
          ),
        ),
      ),
    );
  }

  dialogBakItem(List<PropertiesModel> propertiesList, int index, int tbFileListIndex) {
    final item = propertiesList[index];
    final list = propertiesList.where((element) => element.app_apk_md5 == item.app_apk_md5);
    item.apkSize = item.apkFile.existsSync() ? item.apkFile.lengthSync() : 0;
    item.dataSize = item.dataFile.existsSync() ? item.dataFile.lengthSync() : 0;
    bool canDelAPk = list.length <= 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onSecondaryTap: () {
          showMenu(
            context: context,
            position: RelativeRectExt.fromOffsetExt(offset),
            items: [
              PopupMenuItem(
                child: const Text('删除'),
                onTap: () => deleteAll(item, canDelAPk, propertiesList, index, tbFileListIndex),
              ),
              PopupMenuItem(
                enabled: item.apkFile.existsSync(),
                child: const Text('仅删除APK'),
                onTap: () => deleteApk(item, canDelAPk),
              ),
              PopupMenuItem(
                enabled: item.dataFile.existsSync(),
                child: const Text('仅删除数据'),
                onTap: () => deleteData(item, propertiesList, index),
              ),
            ],
          );
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.precise,
          onHover: (event) {
            offset = event.position;
          },
          child: ListTile(
            tileColor: item.isSys ? Colors.red.withOpacity(0.5) : Colors.white,
            contentPadding: const EdgeInsets.all(5),
            leading: item.iconWidget,
            title: Text(item.app_gui_label, style: TextStyle(color: item.isLock ? Colors.orange : Colors.black)),
            subtitle: Text("${item.date} - ${item.time}\n"
                "APK: ${item.apkSizeStr()}　数据: ${item.dataSizeStr()}　总: ${item.totalSizeStr()}"),
            trailing: IconButton(
              icon: Icon(item.isLock ? Icons.lock : (canDelAPk ? Icons.delete_forever : Icons.delete)),
              onPressed: () {
                deleteDialog('此删除会删除数据和无其他备份引用的Apk。\n\n如果想只删除数据或者只删除Apk,请使用子菜单的删除功能').then((dv) {
                  if (dv == true) {
                    if (item.dataFile.existsSync()) item.dataFile.deleteSync();
                    if (canDelAPk && item.apkFile.existsSync()) item.apkFile.deleteSync();
                    if (item.propertiesFile.existsSync()) item.propertiesFile.deleteSync();
                    propertiesList.removeAt(index);
                    if (propertiesList.isEmpty) {
                      svranToast("已删除完");
                      tbFileList.removeAt(tbFileListIndex);
                      Navigator.pop(context);
                    }
                    setState(() {});
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void deleteApk(PropertiesModel item, canDelAPk) {
    Future.delayed(
      const Duration(seconds: 0),
      () => deleteDialog(canDelAPk ? "仅仅删除Apk, 保留数据?" : "⚠️其他备份引用了这个Apk!\n\n⚠️删除后,其他备份将失去引用!\n\n⚠️确定删除?").then(
        (dv) {
          if (dv == true) {
            if (item.apkFile.existsSync()) {
              item.apkFile.deleteSync();
              item.apkSize = 0;
            }
            setState(() {});
          }
        },
      ),
    );
  }

  Future<bool?> deleteDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除?'),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消', style: TextStyle(color: Colors.black38)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认'),
          )
        ],
        content: Text(message),
      ),
    );
  }

  void deleteAll(PropertiesModel item, bool canDelAPk, List<PropertiesModel> propertiesList, index, tbFileListIndex) {
    Future.delayed(
      const Duration(seconds: 0),
      () => deleteDialog('删除数据(和无其他备份引用的Apk)').then(
        (dv) {
          if (dv == true) {
            if (item.dataFile.existsSync()) item.dataFile.deleteSync();
            if (canDelAPk && item.apkFile.existsSync()) item.apkFile.deleteSync();
            if (item.propertiesFile.existsSync()) item.propertiesFile.deleteSync();
            propertiesList.removeAt(index);
            if (propertiesList.isEmpty) {
              svranToast("已删除完");
              tbFileList.removeAt(tbFileListIndex);
              Navigator.pop(context);
            }
            setState(() {});
          }
        },
      ),
    );
  }

  void deleteData(PropertiesModel item, List<PropertiesModel> propertiesList, index) {
    Future.delayed(
      const Duration(seconds: 0),
      () => deleteDialog('删除数据').then(
        (dv) {
          if (dv == true) {
            if (item.dataFile.existsSync()) item.dataFile.deleteSync();
            // if (propertiesList.length > 1 && item.propertiesFile.existsSync()) {
            //   item.propertiesFile.deleteSync();
            //   propertiesList.removeAt(index);
            // }
            setState(() {});
          }
        },
      ),
    );
  }
}
