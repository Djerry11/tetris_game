import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/tetromino_pieces.dart';

import '../values.dart';

Piece nextPiece =
    Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);

class TetrisState {
  // Define your game state variables here
  int score = 0;
  bool isPaused = false;
  Piece currentPiece = nextPiece;
  List<int> piecePosition = Piece(shape: nextPiece.shape).position;
  Timer gameLoopTimer = Timer.periodic(duration, (timer) {});
}

class TetrisNotifier extends StateNotifier<TetrisState> {
  TetrisNotifier() : super(TetrisState()) {
    // Initialize your game state variables here
    state.score = 0;
  }
  //create piece and loop the game
  void startGame() {
    // Identify the shape of the current piece
    state.currentPiece.initializePiece();

    // Cancel the previous timer if it exists
    gameLoopTimer?.cancel();

    // Screen refresh time
    Duration frameRefreshRate = const Duration(milliseconds: 800);

    // Start the new game loop timer
    gameLoopTimer = loopGame(frameRefreshRate);
  }

  // Your game-related logic and state management methods here
  // Define methods to move pieces, rotate, reset game, etc.
}

final tetrisProvider = StateNotifierProvider<TetrisNotifier, dynamic>((ref) {
  return TetrisNotifier();
});
