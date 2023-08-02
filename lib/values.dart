//total number of rows and columns in the game
int maxRow = 10;
int maxCol = 15;

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
