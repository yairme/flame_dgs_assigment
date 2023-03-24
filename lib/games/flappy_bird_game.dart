import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_dgs_assigment/components/background_component.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/inputs/controls.dart';

import '../constants/globals.dart';

class FlappyBirdGame extends FlameGame with HasTappables {
  Button button = Button();
  final Vector2 buttonSize = Vector2(200.0, 100.0);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(PlayerComponent());

    button
      ..sprite = await loadSprite(Global.buttonSprite)
      ..size = buttonSize
      ..position = size / 2 - Vector2(0, -275)
      ..anchor = Anchor.center;

    add(button);
  }
}
