import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "GAME OVER";
    String subtitle = 'PRESS START \nTO \nPLAY \nAGAIN';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Press',
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Press',
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
