import 'package:flame/components.dart';
import 'package:flame/input.dart';

class Button extends SpriteComponent with Tappable {
  int isPressed = 0;
  @override
  bool onTapDown(TapDownInfo event) {
    try {
      isPressed = 1;
      print('It is being press.');
      return true;
    } catch (error) {
      isPressed = 0;
      print('error');
      return false;
    }
  }
}
