import 'package:flutter_test/flutter_test.dart';
import 'package:svran_flutter_study/study/test/counter.dart';

main() {
  group("", () {
    late Counter counter;
    setUpAll(() {
      // 所有测试之前开始执行的代码.
      counter = Counter();
    });

    test("counter test def value", () {
      expect(counter.value, 0);
    });

    test("counter test --", () {
      counter.decrement();
      expect(counter.value, -1);
    });

    test("counter test ++", () {
      counter.increment();
      expect(counter.value, 1);
    });
  });
}
