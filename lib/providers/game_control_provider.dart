import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/resources/board_presets.dart';
import 'package:tetris_game/resources/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  maxRow,
  (row) => List.generate(maxCol, (col) => null),
);
final gameController = StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});

class GameController extends StateNotifier<GameState> {
  var i = 0;
  Timer? gameLoopTimer;
  Piece nextPiece =
      Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);
  int refreshTime = 800;
  late Piece currentPiece;
  int currentScore = 0;

  GameController() : super(GameState.initial()) {
    state = state.copyWith(gameBoard: initialBoard);
  }

  void startGame() {
    //initialize the board
    state = state.copyWith(gameBoard: gameBoard);
    //set the current piece to the next piece
    currentPiece = nextPiece.copyWith().initializePiece();

    nextPiece = Piece(
        shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);
    state = state.copyWith(nextPiece: nextPiece);
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
          clearLine();
          checkLanding();
          if (state.gameOver) {
            timer.cancel();
            //showGameOverMessage(BuildContext);
          }
          currentPiece = currentPiece.movePiece(Direction.down);
          state = state.copyWith(currentPiece: currentPiece);
        }
      },
    );
  }

  bool checkCollisions(Direction direction) {
    //check if the piece can move in the direction
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and column of the piece in board
      int row = (currentPiece.position[i] / maxCol).floor();
      int col = currentPiece.position[i] % maxCol;
      //calculate the next position of the piece in board
      if (row + 1 < maxRow && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }

      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.left) {
        col--;
        //check if left place is occipied
        if (gameBoard[row][col] != null) {
          return true;
        }
      } else if (direction == Direction.right) {
        col++;
        //check if right place is occipied
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
      //check if the piece is at the ends of the board and movements can be done or not
      if (col < 0 || row >= maxRow || col >= maxCol) {
        return true;
      }
    }
    //if the piece is not at the ends of the board
    return false;
  }

  void checkLanding() {
    if (checkCollisions(Direction.down)) {
      //stop the piece from moving
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / maxCol).floor();
        int col = currentPiece.position[i] % maxCol;

        //store the piece in the board after landing
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.shape;
        }
      }
      currentScore += 100;
      state = state.copyWith(currentScore: currentScore);
      //create new piece after landing
      createNewPiece();
    }
  }

  void createNewPiece() {
    currentPiece = nextPiece.copyWith().initializePiece();
    //create new random piece
    Random ran = Random();
    Tetromino newShape = Tetromino.values[ran.nextInt(Tetromino.values.length)];
    nextPiece = Piece(shape: newShape);
    state = state.copyWith(nextPiece: nextPiece);
//check if the game is over
    if (isGameOver()) {
      state = state.copyWith(gameOver: true);
      // showGameOverMessage();
    }
  }

  bool isGameOver() {
    //if the piece is at the top of the board
    for (int col = 0; col < maxCol; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  void clearLine() {
    //loop through each row on the board from bottom
    for (int row = maxRow - 1; row >= 0; row--) {
      bool canClear = true;
      //check if the row is full or not by checking each column
      for (int col = 0; col < maxCol; col++) {
        if (gameBoard[row][col] == null) {
          canClear = false;
          break;
        }
      }
      //if the row is full then clear the row and move the pieces down
      if (canClear) {
        //move the pieces down row by row
        for (int i = row; i > 0; i--) {
          gameBoard[i] = List.from(gameBoard[i - 1]);
        }
        //set the top row to null
        gameBoard[0] = List.generate(maxCol, (col) => null);
        //increase the score by 100
        //
        currentScore += 500;
        state = state.copyWith(currentScore: currentScore);
      }
    }
  }

  void resetGame() {
    gameBoard =
        List.generate(maxRow, (row) => List.generate(maxCol, (col) => null));
    state =
        state.copyWith(gameBoard: gameBoard, currentScore: 0, gameOver: false);

    // Cancel the previous timer if it exists
    gameLoopTimer?.cancel();

    createNewPiece();
    startGame();
  }

  //check if the game is over

//show alert dialog box when game is over

  //setting functions
  void toggleVibration() {
    state = state.copyWith(vibrate: !state.vibrate);
  }

  void toggleColor() {
    state = state.copyWith(isColor: !state.isColor);
    // state = GameSettingState(isColor: !state.isColor);
  }

  void toggleBackground() {
    state = state.copyWith(
        screenColor: colorGradients[++i % colorGradients.length]);
  }

  void togglePause() {
    state = state.copyWith(isPaused: !state.isPaused);
  }

  //functions
  void rotatePiece() {
    if (!state.isPaused) {
      currentPiece = currentPiece.rotatePiece();
      state = state.copyWith(currentPiece: currentPiece);
    }
  }

  void moveLeft() {
    if (!state.isPaused) {
      if (!checkCollisions(Direction.left)) {
        currentPiece = currentPiece.movePiece(Direction.left);
        state = state.copyWith(currentPiece: currentPiece);
      }
    }
  }

  void moveRight() {
    if (!state.isPaused) {
      if (!checkCollisions(Direction.right)) {
        currentPiece = currentPiece.movePiece(Direction.right);
        state = state.copyWith(currentPiece: currentPiece);
      }
    }
  }

  void dropPiece() {
    if (!state.isPaused) {
      // Keep moving the piece down until it collides or reaches the bottom
      while (!checkCollisions(Direction.down)) {
        currentPiece = currentPiece.movePiece(Direction.down);
        state = state.copyWith(currentPiece: currentPiece);
      }
      // Handle landing and create a new piece
      checkLanding();
    }
  }

  void dropPieceBySteps(int steps) {
    if (!state.isPaused) {
      // Move the piece down by the specified number of steps
      for (int i = 0; i < steps; i++) {
        if (!checkCollisions(Direction.down)) {
          currentPiece = currentPiece.movePiece(Direction.down);
          state = state.copyWith(currentPiece: currentPiece);
        } else {
          break;
        }
      }
      // Handle landing and create a new piece
      checkLanding();
    }
  }
}
