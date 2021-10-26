import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:svran_flutter_study/study/test/widget/contacts.dart';

main() {
  testWidgets("测试联系人", (tester) async {
    // 注入widget
    await tester.pumpWidget(
      const MaterialApp(
        home: SvranContacts(
          ["aaa", "bbb", "ccc", "ddd", "eee", "aaa", "bbb", "eee"],
        ),
      ),
    );

    // 在widget中,查找某些widget
    final aaaText = find.text("aaa");
    final bbbText = find.text("bbb");
    final cccText = find.text("ccc");
    final dddText = find.text("ddd");
    final eeeText = find.text("eee");

    final icon = find.byIcon(Icons.people);

    expect(aaaText, findsNWidgets(2));
    expect(bbbText, findsNWidgets(2));
    expect(bbbText, findsNWidgets(2));
    expect(cccText, findsOneWidget);
    expect(dddText, findsOneWidget);
    expect(eeeText, findsNWidgets(2));
    // expect(eeeText, findsOneWidget);

    expect(icon, findsNWidgets(8));
  });
}
