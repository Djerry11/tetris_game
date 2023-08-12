import 'package:tetris_game/resources/values.dart';

//dummy board at the launch of the game

List<List<Tetromino?>> deepCopyBoard(List<List<Tetromino?>> originalList) {
  List<List<Tetromino?>> copiedList = [];

  for (int row = 0; row < originalList.length; row++) {
    List<Tetromino?> rowList = [];
    for (int col = 0; col < originalList[row].length; col++) {
      // Assuming Tetromino is a class that can be copied
      Tetromino? element =
          originalList[row][col]; // Use the appropriate copy method here
      rowList.add(element);
    }
    copiedList.add(rowList);
  }
  return copiedList;
}

const List<List<Tetromino?>> initialBoard = [
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [
    Tetromino.I,
    Tetromino.I,
    Tetromino.L,
    null,
    Tetromino.S,
    Tetromino.S,
    Tetromino.S,
    Tetromino.O,
    null,
    Tetromino.O
  ],
  [
    Tetromino.I,
    Tetromino.I,
    Tetromino.L,
    null,
    Tetromino.S,
    Tetromino.Z,
    Tetromino.S,
    null,
    Tetromino.O,
    null
  ],
  [
    Tetromino.I,
    null,
    Tetromino.L,
    Tetromino.L,
    Tetromino.S,
    null,
    Tetromino.S,
    null,
    Tetromino.O,
    null
  ],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [
    null,
    null,
    Tetromino.I,
    Tetromino.I,
    Tetromino.I,
    Tetromino.I,
    null,
    null,
    null,
    null
  ],
  [null, null, null, null, null, null, null, null, null, null],
  [
    null,
    null,
    null,
    null,
    Tetromino.J,
    Tetromino.J,
    Tetromino.J,
    null,
    null,
    null
  ],
  [
    null,
    null,
    null,
    null,
    Tetromino.Z,
    Tetromino.Z,
    Tetromino.J,
    Tetromino.I,
    null,
    null
  ],
  [
    null,
    null,
    null,
    Tetromino.T,
    null,
    Tetromino.Z,
    Tetromino.Z,
    Tetromino.I,
    null,
    null
  ],
  [
    null,
    null,
    Tetromino.T,
    Tetromino.T,
    Tetromino.T,
    Tetromino.T,
    Tetromino.T,
    Tetromino.I,
    null,
    null
  ],
  [
    Tetromino.J,
    Tetromino.J,
    null,
    Tetromino.J,
    Tetromino.J,
    Tetromino.J,
    null,
    null,
    Tetromino.L,
    null
  ],
  [
    Tetromino.J,
    null,
    null,
    null,
    Tetromino.T,
    Tetromino.J,
    Tetromino.L,
    Tetromino.L,
    Tetromino.L,
    null
  ],
  [
    Tetromino.J,
    Tetromino.S,
    null,
    Tetromino.T,
    Tetromino.T,
    Tetromino.T,
    Tetromino.L,
    Tetromino.S,
    null,
    Tetromino.Z
  ],
  [
    null,
    Tetromino.O,
    Tetromino.S,
    null,
    Tetromino.T,
    Tetromino.T,
    Tetromino.T,
    null,
    Tetromino.S,
    Tetromino.S,
  ],
  [
    Tetromino.J,
    Tetromino.S,
    Tetromino.S,
    Tetromino.T,
    Tetromino.T,
    Tetromino.T,
    null,
    null,
    Tetromino.S,
    Tetromino.S
  ],
  [
    Tetromino.S,
    Tetromino.S,
    Tetromino.I,
    Tetromino.I,
    Tetromino.I,
    Tetromino.I,
    null,
    Tetromino.S,
    Tetromino.S,
    null
  ],
  [
    null,
    Tetromino.L,
    Tetromino.Z,
    Tetromino.I,
    Tetromino.I,
    Tetromino.I,
    Tetromino.I,
    null,
    Tetromino.O,
    Tetromino.O,
    null
  ]
];
const List<List<Tetromino?>> emptyGameBoard = [
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
  [null, null, null, null, null, null, null, null, null, null],
];
