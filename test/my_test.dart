import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Testing Matrix", () {
    final _transformMatrix = Matrix4.identity()
      ..translate(100, 100)
      ..rotateZ(15)
      ..scale(10, 10, 1)
      ..translate(0, 0);
  });
}
