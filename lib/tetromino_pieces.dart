import 'dart:ui';

import 'package:tetris_game/values.dart';

import 'home_screen.dart';

class Piece {
  //shape of tetromino
  Tetromino shape;
  Piece({required this.shape});

  Color get color =>
      tetrominoColor[shape] ?? const Color.fromARGB(0, 249, 248, 248);

  //position of grid for tetromino
  List<int> position = [];

  void initializePiece() {
    //determine the shape of tetromino in gridboard
    switch (shape) {
      case Tetromino.I:
        position = [
          -7,
          -6,
          -5,
          -4,
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
          -14,
          -15,
          -5,
          -6,
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
          -5,
          -6,
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

  var rotationState = 1;
  void rotatePiece() {
    List<int> newPosition = [];
    //rotatre the tetromino
    switch (shape) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*
            o
            o
            o o
          */
            newPosition = [
              position[1] - maxCol,
              position[1],
              position[1] + maxCol,
              position[1] + maxCol + 1,
            ];
            //check if the new postion is valid and update accordingly
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
              o o o
              o
          */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + maxCol - 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
           o o
             o
             o
          */
            newPosition = [
              position[1] + maxCol,
              position[1],
              position[1] - maxCol,
              position[1] - maxCol - 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
            o o o 
          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] - maxCol + 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            /*
            o
            o
          o o 
          */
            newPosition = [
              position[1] - maxCol,
              position[1],
              position[1] + maxCol,
              position[1] + maxCol - 1,
            ];
            //check if the new postion is valid and update accordingly
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
              o
              o o o
              
          */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - maxCol - 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
             o o
             o
             o
          */
            newPosition = [
              position[1] + maxCol,
              position[1],
              position[1] - maxCol,
              position[1] - maxCol + 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
            o o o 
                o
          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + maxCol + 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            /*
          o o o
            o
            
          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + maxCol,
            ];
            //check if the new postion is valid and update accordingly
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            /*
              o
            o o
              o
          */
            newPosition = [
              position[1] - maxCol,
              position[1],
              position[1] + maxCol,
              position[1] - 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            /*
             o
           o o o
          */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - maxCol,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            /*
                o
                o o
                o 
          */
            newPosition = [
              position[1] + maxCol,
              position[1],
              position[1] - maxCol,
              position[1] + 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            /*
          o o
            o o
          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + maxCol,
              position[1] + maxCol + 1,
            ];
            //check if the new postion is valid and update accordingly
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 2;
            }
            break;
          case 1:
            /*
                o
              o o
              o
          */
            newPosition = [
              position[1] - maxCol,
              position[1],
              position[1] - 1,
              position[1] + maxCol - 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 2;
            }
            break;
        }
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            /*
              o o
            o o
          */
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] + maxCol,
              position[1] + maxCol - 1,
            ];
            //check if the new postion is valid and update accordingly
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 2;
            }
            break;
          case 1:
            /*
              o
              o o
                o
          */
            newPosition = [
              position[1] - maxCol,
              position[1],
              position[1] + 1,
              position[1] + maxCol + 1,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 2;
            }
            break;
        }
        break;
      case Tetromino.O:
        switch (rotationState) {
          /*
          o o
          o o
          */
        }
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            /*
            o o o o
            
          */
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            //check if the new postion is valid and update accordingly
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 2;
            }
            break;
          case 1:
            /*
              o
              o
              o
              o
              
          */
            newPosition = [
              position[1] - maxCol,
              position[1],
              position[1] + maxCol,
              position[1] + 2 * maxCol,
            ];
            if (isPiecePosValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 2;
            }
            break;
        }
        break;

      default:
    }
  }

  bool isPosValid(int position) {
    //get the row and column according to the position of piece
    int row = (position / maxCol).floor();
    int col = position % maxCol;
    //return false if the position is occupied in the board
    if (row < 0 || gameBoard[row][col] != null || col < 0) {
      return false;
    } else {
      return true;
    }
  }

  bool isPiecePosValid(List<int> piecePos) {
    bool isInFirstCol = false;
    bool isInLastCol = false;
    //check for each position of piece
    for (int pos in piecePos) {
      //return false if any one of the position is invalid
      if (!isPosValid(pos)) {
        return false;
      }
      //check if the piece is in first column
      if (pos % maxCol == 0) {
        isInFirstCol = true;
      }
      //check if the piece is in last column
      if (pos % maxCol == maxCol - 1) {
        isInLastCol = true;
      }
    }
    //return false if the piece is in first and last column
    if (isInFirstCol && isInLastCol) {
      return false;
    } else {
      return true;
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
