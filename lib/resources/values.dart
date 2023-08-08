//total number of rows and columns in the game

import 'package:flutter/material.dart';

int maxRow = 20;
int maxCol = 10;

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
  /*
    I tetromino
      o
      o
      o
      o
    O tetromino
      oo
      oo
    T tetromino
      ooo
       o
       O
    S tetromino
       oo
      oo
    Z tetromino
      oo
       oo 
    J tetromino
      o
      o
     oo
    L tetromino
      o
      o
      oo
  */
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

class Homecolor {
  List<Color> color1 = [
    Colors.green,
    Colors.purple,
  ];
  List<Color> color2 = [
    Colors.blue,
    const Color.fromARGB(255, 22, 115, 79),
  ];
}
