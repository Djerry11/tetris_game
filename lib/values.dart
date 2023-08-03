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
const Map<Tetromino, Color> tetrominoColor = {
  Tetromino.I: Color(0xff00ffff),
  Tetromino.O: Color(0xff800080),
  Tetromino.T: Color(0xffffff00),
  Tetromino.S: Color(0xff00ff00),
  Tetromino.Z: Color(0xffff0000),
  Tetromino.J: Color(0xff0000ff),
  Tetromino.L: Color(0xffffa500),
};
