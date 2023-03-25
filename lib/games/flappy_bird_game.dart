import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_dgs_assigment/components/background_component.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/inputs/joystick_component.dart';

import '../constants/globals.dart';

class FlappyBirdGame extends FlameGame with HasDraggables {
  final Vector2 buttonSize = Vector2(200.0, 100.0);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(PlayerComponent(joystick: joystick));

    add(joystick);
  }
}
