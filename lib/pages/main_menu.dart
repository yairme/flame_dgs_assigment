import 'package:flutter/material.dart';
import 'game_play_menu.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;
    // Set the reference screen width
    const double referenceScreenWidth = 375;
    // Calculate the scale factor based on the screen size and reference width
    final double scale = screenSize.width / referenceScreenWidth;
    // Calculate the font size based on the scale factor
    final double fontSize = 48 * scale;

    // Return a Scaffold widget with a Stack as its body
    return Scaffold(
      body: Stack(
        children: [
          // Add a Container widget with a background color
          Container(
            color: const Color.fromARGB(
                255, 32, 0, 148), // set background color here
          ),
          // Add a Column widget with two Expanded widgets
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add an Expanded widget with a centered Text widget
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
              // Add an Expanded widget with a centered ElevatedButton widget
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
