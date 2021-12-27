import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svran_flutter_study/boom/widget/boom_widget.dart';
import 'package:svran_flutter_study/ext/toast/svran_toast.dart';
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
    final title = widget.propertiesList[0].app_label;
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
    bool canDelAPk = list.length <= 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: item.isSys ? Colors.red.withOpacity(0.5) : Colors.white,
        contentPadding: const EdgeInsets.all(5),
        leading: item.iconWidget,
        title: Text(item.app_gui_label, style: TextStyle(color: item.isLock ? Colors.orange : Colors.black)),
        subtitle: Text("${item.date} - ${item.time}\n"
            "APP:${item.apkSizeStr()}　DATA:${item.dataSizeStr()}　总:${item.totalSizeStr()}"),
        trailing: IconButton(
          icon: Icon(item.isLock ? Icons.lock : (canDelAPk ? Icons.delete_forever : Icons.delete)),
          onPressed: () {
            deleteDialog().then((dv) {
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
    );
  }

  Future<bool?> deleteDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除?'),
        actions: [
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('确认', style: TextStyle(color: Colors.red)),
          )
        ],
      ),
    );
  }
}
