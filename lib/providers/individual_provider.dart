import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/resources/values.dart';

import 'game_control_provider.dart';

final isInitialLaunch = StateProvider<bool>((ref) {
  return true;
});
//Background Color Notifier for the game
var i = 0;

class ScreenNotifier extends StateNotifier<List<Color>> {
  ScreenNotifier() : super(colorGradients[5]);

  void toggleBackground() {
    state = colorGradients[++i % colorGradients.length];
  }

  void toggleBack() {
    state = colorGradients[--i % colorGradients.length];
  }
}

final gradientProvider =
    StateNotifierProvider<ScreenNotifier, List<Color>>((ref) {
  return ScreenNotifier();
});

//Piece Color Notifier Provider for the game
class PieceColorNotifier extends StateNotifier<bool> {
  PieceColorNotifier() : super(true);

  void toggleColor() {
    state = !state;
  }
}

final pieceColorProvider =
    StateNotifierProvider<PieceColorNotifier, bool>((ref) {
  return PieceColorNotifier();
});

//Score provider for the game extends from the game controller
final scoreProvider = StateProvider<int>((ref) {
  final gameScore = ref.watch(gameController).currentScore;
  return gameScore;
});
//current piece provider extends from the game controller
final currentPieceProvider = StateProvider<Piece>((ref) {
  final currentPiece = ref.watch(gameController).currentPiece;
  return currentPiece;
});

//NextPiece provider for the game extends from the game controller
final nextPieceProvider = StateProvider<Piece>((ref) {
  final nextPiece = ref.watch(gameController).nextPiece;
  return nextPiece;
});

//gameBoard provider
final gameBoardProvider = StateProvider<List<List<Tetromino?>>>((ref) {
  final gameBoard = ref.watch(gameController).gameBoard;
  return gameBoard;
});

//Provider for the vibration control
class VibrationNotifier extends StateNotifier<bool> {
  VibrationNotifier() : super(true);

  void toggleVibration() {
    state = !state;
  }
}

final vibrationProvider = StateNotifierProvider<VibrationNotifier, bool>((ref) {
  return VibrationNotifier();
});

//for managing the high score using shared preferences
class HighScoreNotifier extends StateNotifier<int> {
  HighScoreNotifier() : super(0) {
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final highScore = prefs.getInt('highScore') ?? 0;
    state = highScore;
  }

  Future<void> _updateHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('highScore', score);
    state = score;
  }

  void saveHighScore(int newScore) {
    if (newScore > state) {
      _updateHighScore(newScore);
    }
  }
}

final highScoreProvider = StateNotifierProvider<HighScoreNotifier, int>((ref) {
  return HighScoreNotifier();
});
