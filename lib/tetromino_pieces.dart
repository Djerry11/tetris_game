import 'package:tetris_game/values.dart';

class Piece {
  //shape of tetromino
  Tetromino shape;
  Piece({required this.shape});

  //position of grid for tetromino
  List<int> position = [];

  void initializePiece() {
    //determine the shape of tetromino in gridboard
    switch (shape) {
      case Tetromino.I:
        position = [
          -35,
          -25,
          -15,
          -5,
        ];
        break;
      case Tetromino.O:
        position = [
          -16,
          -15,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -16,
          -15,
          -14,
          -5,
        ];

        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];

        break;
      case Tetromino.Z:
        position = [
          -16,
          -15,
          -5,
          -4,
        ];

        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -6,
          -5,
        ];

        break;
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];

        break;
      default:
        break;
    }
  }

  //movement of tetromino
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.left:
        position = position.map((pos) => pos - 1).toList();
        break;
      case Direction.right:
        position = position.map((pos) => pos + 1).toList();
        break;
      case Direction.down:
        position = position.map((pos) => pos + maxRow).toList();
        break;
    }
  }
}
