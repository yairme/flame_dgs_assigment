import 'package:flutter/material.dart';
import 'game_play_menu.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double referenceScreenWidth = 375;
    final double scale = screenSize.width / referenceScreenWidth;
    final double fontSize = 48 * scale;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(
                255, 32, 0, 148), // set background color here
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Flappy Bird',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32 * scale),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GamePlay()),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          Size(200 * scale, 60 * scale)),
                    ),
                    child: Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 24 * scale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
