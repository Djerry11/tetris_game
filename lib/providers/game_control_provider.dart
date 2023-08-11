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
late List<List<Tetromino?>> emptyGameBoard;

//StateNotifier Provider for the game
final gameController = StateNotifierProvider<GameController, GameState>((ref) {
  return GameController();
});

class GameController extends StateNotifier<GameState> {
  var i = 0;
  Timer? gameLoopTimer;

  //create the next piece
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
    gameBoard =
        List.generate(maxRow, (row) => List.generate(maxCol, (col) => null));
    state =
        state.copyWith(gameBoard: gameBoard, currentScore: 0, gameOver: false);
    //create empty board
    emptyGameBoard =
        List.generate(maxRow, (row) => List.generate(maxCol, (col) => null));
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
      (timer) async {
        //move the piece down
        if (!state.isPaused) {
          clearLine();
          checkLanding();
          if (state.gameOver) {
            timer.cancel();

            return;
            //showGameOverMessage(BuildContext);
          }
          currentPiece = currentPiece.movePiece(Direction.down);
          state = state.copyWith(currentPiece: currentPiece);
        }
      },
    );
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

  void createNewPiece() async {
    currentPiece = nextPiece.copyWith().initializePiece();
    //create new random piece
    Random ran = Random();
    Tetromino newShape = Tetromino.values[ran.nextInt(Tetromino.values.length)];
    nextPiece = Piece(shape: newShape);
    state = state.copyWith(nextPiece: nextPiece);
//check if the game is over
    if (isGameOver()) {
      gameLoopTimer?.cancel();

      await fillGameBoardOneByOne();
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

  //fill animation

  // Future<void> fillGameBoardOneByOne() async {
  //   for (int row = 0; row < maxRow; row++) {
  //     for (int col = 0; col < maxCol; col++) {
  //       state.gameBoard[row][col] = Tetromino.I; // Set the piece
  //       state = state.copyWith(); // Update the state to trigger UI update

  //       await Future.delayed(
  //           const Duration(milliseconds: 20)); // Delay between cells

  //       state.gameBoard[row][col] = null; // Clear the cell
  //       state = state.copyWith(); // Update the state again
  //     }
  //   }
  // }
  Future<void> fillGameBoardOneByOne() async {
    // print('UTSAB: EMPTY $emptyGameBoard');
    // print('UTSAB: GAME $gameBoard');
    // print('UTSAB: STATE (${state.gameBoard})');
    // state = state.copyWith(currentPiece: currentPiece.initializePiece());
    // state = state.copyWith(gameBoard: emptyGameBoard);
    //clear the screen first with animation
    for (int row = 0; row < maxRow; row++) {
      for (int col = 0; col < maxCol; col++) {
        if (state.gameBoard[row][col] != null) {
          await _clearCell(row, col, 1);
        }
      }
    }
    int mnRow = 0;
    int mxRow = maxRow - 1;
    int mnCol = 0;
    int mxCol = maxCol - 1;

    while (mnRow <= mxRow && mnCol <= mxCol) {
      // Fill top row
      for (int col = mnCol; col <= mxCol; col++) {
        await _fillCell(mnRow, col);
      }

      // Fill right column (excluding corners)
      for (int row = mnRow + 1; row <= mxRow - 1; row++) {
        await _fillCell(row, mxCol);
      }

      // Fill bottom row
      if (mnRow < mxRow) {
        for (int col = mxCol; col >= mnCol; col--) {
          await _fillCell(mxRow, col);
        }
      }

      // Fill left column (excluding corners)
      if (mnCol < mxCol) {
        for (int row = mxRow - 1; row >= mnRow + 1; row--) {
          await _fillCell(row, mnCol);
        }
      }

      mnRow++;
      mxRow--;
      mnCol++;
      mxCol--;
    }
    // Clear specified range of cells in reverse order
    for (int row = 12; row >= 3; row--) {
      for (int col = 7; col >= 2; col--) {
        await _clearCell(row, col, 1);
      }
    }
  }

//fuction to fill the cell in board
  Future<void> _fillCell(int row, int col) async {
    state.gameBoard[row][col] = state.currentPiece.shape;
    state = state.copyWith(); // Update the state to trigger UI update
    await Future.delayed(
        const Duration(milliseconds: 4)); // Delay between cells
  }

  //function to clear the cell in board
  Future<void> _clearCell(int row, int col, int time) async {
    state.gameBoard[row][col] = null; // Clear the cell
    state = state.copyWith(); // Update the state to trigger UI update
    await Future.delayed(Duration(milliseconds: time)); // Delay between cells
  }
}
