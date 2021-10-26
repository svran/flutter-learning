import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

main() {
  group("app集成测试", () {
    late FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      driver.close();
    });

    final testFinder = find.byValueKey("国际化适配");
    final listTileFinder = find.byValueKey("国际化适配");

    test("测试默认值", () async {
      expect(await driver.getText(testFinder), "国际化适配");
    });

    final valueTextFinder = find.byValueKey("key");
    test("测试点击", () async {
      await driver.tap(listTileFinder);
      final k = await driver.getText(valueTextFinder);
      expect(k, "你好 ~ 世界!");
    });
  });
}
