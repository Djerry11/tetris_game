//total number of rows and columns in the game

import 'package:flutter/material.dart';

const int maxRow = 20;
const int maxCol = 10;

//for movements direction of tetromino
enum Direction {
  left,
  right,
  down,
}

//building tetromino details on https://tetris.fandom.com/wiki/Tetromino
enum Tetromino {
  I,
  O,
  T,
  S,
  Z,
  J,
  L,
}

//colors for tetromino https://colorswall.com/palette/9o259
const Map<Tetromino, List<Color>> tetrominoColor = {
  Tetromino.I: [
    Color.fromARGB(80, 174, 181, 161),
    Color.fromARGB(255, 27, 137, 137),
  ],
  Tetromino.O: [
    Color.fromARGB(80, 174, 181, 161),
    Color.fromARGB(255, 133, 12, 133),
  ],
  Tetromino.T: [
    Color.fromARGB(80, 174, 181, 161),
    Color.fromARGB(255, 108, 108, 11),
  ],
  Tetromino.S: [
    Color.fromARGB(80, 174, 181, 161),
    Color.fromARGB(255, 12, 118, 12),
  ],
  Tetromino.Z: [
    Color.fromARGB(80, 174, 181, 161),
    Color.fromARGB(255, 157, 12, 12),
  ],
  Tetromino.J: [
    Color.fromARGB(80, 174, 181, 161),
    Color(0xff0000ff),
  ],
  Tetromino.L: [
    Color.fromARGB(80, 174, 181, 161),
    Color.fromARGB(255, 107, 73, 8),
  ],
};

<<<<<<< HEAD
List<List<Color>> colorGradients = [
  [const Color.fromARGB(255, 138, 84, 185), const Color(0xFF734b6d)],
  [
    const Color.fromARGB(255, 216, 109, 127),
    const Color.fromARGB(255, 133, 63, 22)
  ],
  [const Color(0xFF2193b0), const Color.fromARGB(255, 14, 68, 80)],
  [const Color(0xFFcc2b5e), const Color(0xFF753a88)],
  [
    const Color.fromARGB(255, 133, 76, 84),
    const Color.fromARGB(255, 80, 25, 32)
  ],
  [const Color(0xFFbdc3c7), const Color(0xFF2c3e50)],
  [const Color(0xFFde6262), const Color.fromARGB(255, 94, 47, 18)],
  [const Color.fromARGB(255, 235, 247, 247), const Color(0xFF48b1bf)],
=======
final List<List<Color>> colorGradients = [
  [
    const Color(0xFF8CBC3E),
    const Color(0xFFB0C090),
  ], // Light Beige to Light Green
  [
    const Color(0xFFD0A070),
    const Color(0xFFB0C090)
  ], // Light Brown to Light Beige
  [
    const Color(0xFFD0A070),
    const Color(0xFFF86018),
  ], // Light Red to Light Brown
  [const Color(0xFF94A0FF), const Color(0xFFF86018)], // Light Blue to Light Red
  // Light Yellow to Light Blue
  [
    const Color(0xFFF8D878),
    const Color(0xFFD040C0),
  ], // Light Purple to Light Yellow
  [
    const Color(0xFFD040C0),
    const Color(0xFF0F380F),
  ], // Dark Gray to Light Purple
  [
    const Color(0xFFAAAAAA),
    const Color(0xFF306230)
  ], // Light Gray to Dark Green
  [const Color(0xFF777777), const Color(0xFFAAAAAA)], // Mid Gray to Light Gray
  [const Color(0xFF333333), const Color(0xFF777777)],
  [const Color(0xFFAAAAAA), const Color(0xFF777777)], // Light Gray to Mid Gray
  [const Color(0xFF777777), const Color(0xFF333333)],
>>>>>>> new
];

// Use the above gradientColorPairs and the rest of the code from the previous example

// List<List<Color>> colorGradients = [
//   [const Color.fromARGB(255, 138, 84, 185), const Color(0xFF734b6d)],
//   [
//     const Color.fromARGB(255, 216, 109, 127),
//     const Color.fromARGB(255, 133, 63, 22)
//   ],
//   [const Color(0xFF2193b0), const Color.fromARGB(255, 14, 68, 80)],
//   [const Color(0xFFcc2b5e), const Color(0xFF753a88)],
//   [
//     const Color.fromARGB(255, 133, 76, 84),
//     const Color.fromARGB(255, 80, 25, 32)
//   ],
//   [const Color(0xFFbdc3c7), const Color(0xFF2c3e50)],
//   [const Color(0xFFde6262), const Color.fromARGB(255, 94, 47, 18)],
//   [const Color.fromARGB(255, 235, 247, 247), const Color(0xFF48b1bf)],
// ];

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

//refresh rate for the speed of the game
final List<int> refreshRates = [
  // Level 0
  650, // Level 1
  600, // Level 2
  575, // Level 3
  530, // Level 4
  480, // Level 5
  450, // Level 6
  410, // Level 7
  360, // Level 8
  310, // Level 9
  275, // Level 10
  240, // Level 11
  195, // Level 12
  150, // Level 13
  100, // Level 14
  75,
];
