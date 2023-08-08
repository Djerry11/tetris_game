import 'package:flutter/material.dart';

class ButtonColors {
  List<Color> mainButton = [
    const Color.fromARGB(255, 179, 164, 34),
    const Color.fromARGB(255, 121, 62, 11),
    Colors.yellow[200]!,
    const Color.fromARGB(255, 58, 42, 30),
    const Color.fromARGB(255, 226, 225, 217),
    const Color.fromARGB(255, 58, 50, 50),
  ];

  List<Color> controlButton = [
    const Color.fromARGB(255, 179, 164, 34),
    const Color.fromARGB(255, 121, 62, 11),
    const Color.fromARGB(255, 194, 198, 163),
    const Color.fromARGB(255, 93, 87, 83),
    const Color.fromARGB(255, 204, 204, 188),
    const Color.fromARGB(255, 33, 32, 32),
  ];

  List<Color> tinyButton = [
    const Color.fromARGB(255, 142, 253, 162),
    const Color.fromARGB(255, 12, 255, 89),
    const Color.fromARGB(255, 16, 168, 21),
    const Color.fromARGB(255, 97, 158, 93),
    const Color.fromARGB(255, 16, 168, 21),
    const Color.fromARGB(255, 78, 82, 78),
  ];
  List<Color> resetButton = [
    const Color.fromARGB(255, 242, 89, 89),
    const Color.fromARGB(255, 174, 40, 58),
    const Color.fromARGB(255, 212, 90, 90),
    const Color.fromARGB(255, 167, 12, 61),
    const Color.fromARGB(255, 220, 8, 8),
    const Color.fromARGB(255, 49, 4, 7),
  ];
}

class PieceColor {
  //tetromino color from classic tetris console 90s
  //colorcode for lcd screen background

  List<Color> activePiece = [
    const Color.fromARGB(80, 174, 181, 161),
    const Color(0xff010101),
  ];
  List<Color> bgPiece = [
    const Color.fromARGB(95, 236, 236, 237),
    const Color.fromARGB(102, 158, 171, 167),
  ];

  get inactivePiece => null;
}
