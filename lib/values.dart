//total number of rows and columns in the game
import 'dart:ui';

int maxRow = 15;
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
      0
      0
      0
      0
    O tetromino
      00
      00
    T tetromino
      000
      0
    S tetromino
      00
      00
    Z tetromino
      00
      00   
    J tetromino
      0
      0
     00
    L tetromino
      0
      0
      00
  */
}

//colors for tetromino https://colorswall.com/palette/90259
const Map<Tetromino, Color> tetrominoColor = {
  Tetromino.I: Color(0xff00ffff),
  Tetromino.O: Color(0xffffff00),
  Tetromino.T: Color(0xff800080),
  Tetromino.S: Color(0xff00ff00),
  Tetromino.Z: Color(0xffff0000),
  Tetromino.J: Color(0xff0000ff),
  Tetromino.L: Color(0xffff7f00),
};
