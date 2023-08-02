import 'dart:ui';

import 'package:tetris_game/values.dart';

class Piece {
  //shape of tetromino
  Tetromino shape;
  Piece({required this.shape});

  Color get color =>
      tetrominoColor[shape] ?? const Color.fromARGB(0, 255, 255, 255);

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
    }
  }

  //movement of tetromino
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i]--;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i]++;
        }
        break;

      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += maxCol;
        }
        break;
    }
  }
}
