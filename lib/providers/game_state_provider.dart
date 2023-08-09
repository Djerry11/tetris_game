import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/resources/values.dart';

final gameController = StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});

class GameController extends StateNotifier<GameState> {
  GameController() : super(GameState.initial());

  Timer? gameLoopTimer;
  Piece nextPiece =
      Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);
  late Piece currentPiece;
  int refreshTime = 800;

  //start the game
  void startGame() {
    //set the current piece to the next piece
    currentPiece = nextPiece;
    nextPiece = Piece(
        shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);

    //cancel the timer if it is already running
    gameLoopTimer?.cancel();

    Duration refreshRate = Duration(milliseconds: refreshTime);
    gameLoopTimer = loopGame(refreshRate);
    //loop the game every 500ms
  }

  Timer loopGame(Duration refreshRate) {
    return Timer.periodic(
      refreshRate,
      (timer) {
        //move the piece down
        if (!state.isPaused) {
          currentPiece = currentPiece.movePiece(Direction.down);
          state = state.copyWith(currentPiece: currentPiece);
        }
      },
    );
  }
}
