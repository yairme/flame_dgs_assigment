import 'package:flame/game.dart';
import 'package:flame_dgs_assigment/components/background_component.dart';
import 'package:flame_dgs_assigment/components/obstical_component.dart';
import 'package:flame_dgs_assigment/components/player_component.dart';
import 'package:flame_dgs_assigment/inputs/joystick_component.dart';

class FlappyBirdGame extends FlameGame with HasDraggables {
  final Vector2 buttonSize = Vector2(200.0, 100.0);
  late Item item = Item();
  late PlayerComponent player = PlayerComponent(joystick: joystick);
  late BackgroundComponent backgroundComponent = BackgroundComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(backgroundComponent);

    add(player);

    add(joystick);
  }
}
