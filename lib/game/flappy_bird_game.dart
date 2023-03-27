import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_dgs_assigment/components/background_component.dart';
import 'package:flame_dgs_assigment/components/obstical_component.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/inputs/joystick_component.dart';

import '../constants/globals.dart';

class FlappyBirdGame extends FlameGame with HasDraggables {
  SpriteAnimationComponent playerAnimation = SpriteAnimationComponent();
  final Vector2 buttonSize = Vector2(200.0, 100.0);
  late Item item = Item();
  late PlayerComponent player = PlayerComponent(joystick: joystick);
  late BackgroundComponent backGround = BackgroundComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(backGround);

    add(item);

    add(player);

    var spriteSheet = await images.load(Global.spriteSheet);
    final spriteSize = Vector2(270, 185);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 4, stepTime: 0.3, textureSize: Vector2(270, 185));
    playerAnimation =
        SpriteAnimationComponent.fromFrameData(spriteSheet, spriteData)
          ..x = size.x / 2
          ..y = size.y / 2;

    add(joystick);

    //add(item);
  }

  void checkCollisions() {
    if (player.toRect().overlaps(item.toRect())) {
      // use player reference to check for collisions
      print('Player collided with item!');
      item.removeFromParent();
    }
  }
}
