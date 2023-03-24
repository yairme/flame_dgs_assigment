import 'package:flame/components.dart';
import 'package:flame/input.dart';

class Button extends SpriteComponent with Tappable {
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      print('It is being press.');
      return true;
    } catch (error) {
      print('error');
      return false;
    }
  }
}
