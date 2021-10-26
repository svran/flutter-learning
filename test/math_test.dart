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
}
