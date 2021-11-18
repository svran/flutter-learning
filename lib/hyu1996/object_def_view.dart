import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'object_def.dart';

class ObjectDefView extends StatefulWidget {
  @override
  State<ObjectDefView> createState() => _ObjectDefViewState();
}

class _ObjectDefViewState extends State<ObjectDefView> {
  void _onKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      return;
    }
    final key = event.data.logicalKey;
    if (key == LogicalKeyboardKey.escape) {
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "type",
            style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                EditableText(
                  forceLine: false,
                  controller: TextEditingController(text: "GamePlay"),
                  focusNode: FocusNode(canRequestFocus: true),
                  cursorColor: Colors.black,
                  backgroundCursorColor: Colors.grey,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text("=", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton(
                  elevation: 1,
                  value: ObjectDefKind.Enum,
                  onChanged: (k) {},
                  items: List.of(ObjectDefKind.values.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        describeEnum(e).toLowerCase(),
                        style: TextStyle(color: Color.fromARGB(255, 0, 128, 0), fontWeight: FontWeight.w700),
                      ),
                    );
                  })),
                )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Row(
              children: [Text("gpArena, gpTeam", style: TextStyle(fontWeight: FontWeight.w700))],
            ),
          ),
        ],
      ),
    );
  }
}
