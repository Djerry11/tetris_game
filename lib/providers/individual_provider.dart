import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/resources/values.dart';

import 'game_control_provider.dart';

//Background Color Notifier for the game
var i = 0;
// Load the settings from shared preferences

//for the screen background gradients
class ScreenNotifier extends StateNotifier<List<Color>> {
  ScreenNotifier() : super(colorGradients[8]) {
    _loadSavedGradient();
  }
  void _loadSavedGradient() async {
    final prefs = await SharedPreferences.getInstance();
    final index = (prefs.getInt('gradient') ?? 8) % colorGradients.length;
    i = index;

    state = colorGradients[index];
  }

  void toggleBackground() {
    state = colorGradients[++i % colorGradients.length];
  }

  void toggleBack() {
    state = colorGradients[--i % colorGradients.length];
  }

  int get getGradientIndex => i;

  void setfav(int index) {
    state = colorGradients[index];
  }
}

final gradientProvider =
    StateNotifierProvider<ScreenNotifier, List<Color>>((ref) {
  return ScreenNotifier();
});

//Piece Color Notifier Provider for the game
class PieceColorNotifier extends StateNotifier<bool> {
  PieceColorNotifier(this.ref) : super(true);
  final Ref ref;
  void toggleColor() {
    state = !state;
    ref.read(gradientProvider.notifier).setfav(8);
  }
}

final pieceColorProvider =
    StateNotifierProvider<PieceColorNotifier, bool>((ref) {
  return PieceColorNotifier(ref);
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
  VibrationNotifier() : super(true) {
    _loadSavedVibration();
  }

  Future<void> _loadSavedVibration() async {
    final prefs = await SharedPreferences.getInstance();

    final vibration = prefs.getBool('vibration') ?? true;
    state = vibration;
  }

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

//Provider for the sound control
class SoundNotifier extends StateNotifier<bool> {
  SoundNotifier() : super(true) {
    _loadSavedSound();
  }
  void _loadSavedSound() async {
    final prefs = await SharedPreferences.getInstance();
    final sound = prefs.getBool('sound') ?? true;
    state = sound;
  }

  void toggleSound() {
    state = !state;
  }
}

final soundProvider = StateNotifierProvider<SoundNotifier, bool>((ref) {
  return SoundNotifier();
});

//speed level provider
//changes the screen time

class SpeedLevelNotifier extends StateNotifier<int> {
  SpeedLevelNotifier() : super(0) {
    _loadSavedSpeed();
  }

  void _loadSavedSpeed() async {
    final prefs = await SharedPreferences.getInstance();
    final speed = prefs.getInt('speed') ?? 0;
    state = speed;
  }

  void increaseSpeedLeve() {
    if (state < 14 && state >= 0) {
      state = ++state;
    }
  }

  void decreaseSpeedLevel() {
    if (state > 0 && state <= 14) {
      state = --state;
    }
  }

  int get getRefreshRate => refreshRates[state];
}

final speedLevelProvider =
    StateNotifierProvider<SpeedLevelNotifier, int>((ref) {
  return SpeedLevelNotifier();
});

//game level provider for the game
class GameLevelNotifier extends StateNotifier<int> {
  GameLevelNotifier() : super(0) {
    _loadSavedLevel();
  }
  void _loadSavedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    final level = prefs.getInt('level') ?? 0;
    state = level;
  }

  void increaseGameLevel() {
    if (state < 14 && state >= 0) {
      state = ++state;
    }
  }

  void decreaseGameLevel() {
    if (state > 0 && state <= 14) {
      state = --state;
    }
  }

  int get getGameLevel => state;
}

final gameLevelProvider = StateNotifierProvider<GameLevelNotifier, int>((ref) {
  return GameLevelNotifier();
});

///Provider to disable and enable buttons

final disableButtonProvider = StateProvider<bool>((ref) {
  bool result = ref.watch(gameController).disableButton;
  return result;
});
