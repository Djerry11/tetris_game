import 'dart:core';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/models/board_model.dart';

import 'package:tetris_game/resources/values.dart';

import "../resources/board_presets.dart";

final levelBoardProvider =
    StateNotifierProvider<LevelBoardNotifier, GameBoardState>((ref) {
  return LevelBoardNotifier();
});

class LevelBoardNotifier extends StateNotifier<GameBoardState> {
  LevelBoardNotifier()
      : super(GameBoardState(gameBoard: deepCopyBoard(emptyGameBoard)));

  Future<void> gameLevel(int level) async {
    // Define properties for each level
    int maxRowsToFill = 15; // Maximum rows to fill for any level

    int rowsToFill = level + 1 - 1; // Increase rows to fill with each level
    //determine no of rows to fill according to level
    if (level > 0 && level < 4) {
      rowsToFill = 3;
    } else if (level == 0) {
      rowsToFill = 0;
    } else {
      rowsToFill = level + 1;
    }
    //stores level of scatterness and no of min columns to fill in a row
    //higher the scatterness less the chances of being filled
    List<int> scatterness = [0, 0]; // Adjust scatterness based on level
    switch (level) {
      case < 3:
        scatterness = [5, 7];
        break;
      case < 6:
        scatterness = [4, 6];
        break;
      case < 9:
        scatterness = [3, 4];
        break;
      case < 12:
        scatterness = [2, 5];
        break;
      default:
        scatterness = [3, 6];
        break;
    }
    // Calculate the actual rows to fill, ensuring it doesn't exceed the max
    rowsToFill = rowsToFill <= maxRowsToFill ? rowsToFill : maxRowsToFill;

    // Reset the game board
    List<List<Tetromino?>> newGameBoard = deepCopyBoard(emptyGameBoard);

    // Fill rows randomly up to specified height
    for (int row = maxRow - 1; row >= maxRow - rowsToFill; row--) {
      await _fillRowRandomly(newGameBoard, row, scatterness);
    }

    state = state.copyWith(
        gameBoard: newGameBoard); // Update the state with the final game board
  }

  Future<void> _fillRowRandomly(
      List<List<Tetromino?>> gameBoard, int row, List<int> scatterness) async {
    int count = 0; //count for no of column filled
    do {
      for (int col = 0; col < maxCol; col++) {
        // Simulate placing Tetrominoes randomly based on scatterness
        if (Random().nextInt(scatterness[0]) == 0) {
          ///generate random piece to fill
          Tetromino tetromino =
              Tetromino.values[Random().nextInt(Tetromino.values.length)];
          //if cell is null and count is smaller than total no of col then fill cell else return
          if (gameBoard[row][col] == null) {
            count++;
            if (count < maxCol - 1) {
              gameBoard[row][col] = tetromino;
            } else {
              return; //terminate the filling if the no of item has reached maxCol
            }
          }
        }
      }
    } while (
        count < scatterness[1]); //loop until specified no of columns are filled
  }
}
