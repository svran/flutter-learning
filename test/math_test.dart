import 'package:flutter_test/flutter_test.dart';
import 'package:svran_flutter_study/study/test/math_utils.dart';

void main() {
  group("测试math工具", () {
    test("测试描述(数学计算工具类sum测试)", () {
      final result = sum(10, 10);
      expect(result, 20);
    });
    test("测试描述(数学计算工具类mul测试)", () {
      final result = mul(10, 10);
      expect(result, 100);
    });
  });
  group("测试字符分隔", () {
    String t = "E:\\Download\\testTb\\air.svran.stxp-20210409-062735.properties";
    test("测试分隔1", () {
      String l1 = t.split("\\").last;
      print(l1);
      expect(l1, "air.svran.stxp-20210409-062735.properties");

      String l2 = l1.split("-").last;
      print(l2);
      expect(l2, "062735.properties");

      List<String> lt = l1.split("-");
      lt.removeLast();
      String l3 = lt.join();
      print(l3);
      expect(l3, "air.svran.stxp20210409");

      String package = lt.first;
      print(package);
      expect(package, "air.svran.stxp");

      String date = lt[1];
      print(date);
      expect(date, "20210409");

      String time = l2.split(".").first;
      print(time);
      expect(time, "062735");
    });
  });
}
