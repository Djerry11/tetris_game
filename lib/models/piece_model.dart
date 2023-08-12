import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tetris_game/resources/board_presets.dart';
import 'package:tetris_game/resources/values.dart';

import '../providers/game_control_provider.dart';

part 'piece_model.freezed.dart';

@freezed
class Piece with _$Piece {
  const factory Piece({
    required Tetromino shape,
    @Default([]) List<int> position,
    @Default(1) int rotationState,
  }) = _Piece;
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    required Piece currentPiece,
    required Piece nextPiece,
    required List<List<Tetromino?>> gameBoard,
    required int currentScore,
    required bool gameOver,
    required bool isPaused,
    required bool vibrate,
    required bool isColor,
    required List<Color> screenColor,
  }) = _GameState;

  factory GameState.initial() => GameState(
        currentPiece: const Piece(shape: Tetromino.I, position: []),
        nextPiece: const Piece(shape: Tetromino.I, position: []),
        gameBoard: deepCopyBoard(emptyGameBoard),
        currentScore: 0,
        gameOver: false,
        isPaused: false,
        vibrate: true,
        isColor: true,
        screenColor: [Colors.orangeAccent, Colors.deepPurpleAccent],
      );
}

extension PieceExtension on Piece {
  // Your custom methods here
  List<Color> get color =>
      tetrominoColor[shape] ??
      [const Color.fromARGB(255, 164, 148, 148), Colors.black];

  //position of grid
  Piece initializePiece() {
    List<int> newPosition = [];
    switch (shape) {
      case Tetromino.I:
        newPosition = [-7, -6, -5, -4];
        break;
      case Tetromino.O:
        newPosition.addAll([-16, -15, -6, -5]);
        break;
      case Tetromino.T:
        newPosition.addAll([-16, -15, -14, -5]);
        break;
      case Tetromino.S:
        newPosition.addAll([-14, -15, -5, -6]);
        break;
      case Tetromino.Z:
        newPosition.addAll([-16, -15, -5, -4]);
        break;
      case Tetromino.J:
        newPosition.addAll([-17, -16, -15, -5]);
        break;
      case Tetromino.L:
        newPosition.addAll([-14, -15, -16, -6]);
        break;
      default:
        break;
    }
    return copyWith(position: newPosition);
  }

  Piece initializeNextPiece() {
    List<int> newPosition = List.from(position);
    //determine the shape of tetromino in gridboard
    switch (shape) {
      case Tetromino.I:
        newPosition = [0, 1, 2, 3];
        break;
      case Tetromino.O:
        newPosition = [1, 2, 5, 6];
        break;
      case Tetromino.T:
        newPosition = [1, 2, 3, 6];

        break;
      case Tetromino.S:
        newPosition = [
          1,
          2,
          4,
          5,
        ];

        break;
      case Tetromino.Z:
        newPosition = [
          1,
          2,
          6,
          7,
        ];

        break;
      case Tetromino.J:
        newPosition = [0, 1, 2, 6];

        break;
      case Tetromino.L:
        newPosition = [1, 2, 3, 5];

        break;
      default:
    }
    return copyWith(position: newPosition);
  }

  Piece movePiece(Direction direction) {
    List<int> newPosition = List.from(position);
    switch (direction) {
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          newPosition[i]--;
        }
        break;

      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          newPosition[i]++;
        }
        break;

      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          newPosition[i] += maxCol;
        }
        break;
    }
    return copyWith(position: newPosition);
  }

  bool isPosValid(int position) {
    //get the row and column according to the position of piece
    int row = (position / maxCol).floor();
    int col = position % maxCol;
    //return false if the position is occupied in the board
    if (row < -2 || gameBoard[row][col] != null || col < 0) {
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

  Piece rotatePiece() {
    List<int> newPosition = List.from(position);
    int rotation = rotationState;
    //rotatre the tetromino
    switch (shape) {
      case Tetromino.L:
        switch (rotationState) {
          case 3:
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
              rotation = (rotation + 1) % 4;

              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
          case 0:
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
          case 1:
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
          case 2:
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 1:
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
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
              position[1] - maxCol - 1,
            ];
            if (isPiecePosValid(newPosition)) {
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
          case 3:
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
          case 0:
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 4;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 2;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 2;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 2;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 2;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 2;
              return copyWith(position: newPosition, rotationState: rotation);
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
              rotation = (rotation + 1) % 2;
              return copyWith(position: newPosition, rotationState: rotation);
            }
            break;
        }
        break;

      default:
    }
    return this;
  }
}

// Add more custom methods if needed
