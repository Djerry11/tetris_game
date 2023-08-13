import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/providers/individual_provider.dart';
import 'package:tetris_game/providers/level_board_provider.dart';
import 'package:tetris_game/resources/board_presets.dart';
import 'package:tetris_game/resources/values.dart';

List<List<Tetromino?>> gameBoard = deepCopyBoard(emptyGameBoard);
//StateNotifier Provider for the game
final gameController = StateNotifierProvider<GameController, GameState>((ref) {
  return GameController(ref);
});

class GameController extends StateNotifier<GameState> {
  GameController(this.ref) : super(GameState.initial()) {
    state = state.copyWith(gameBoard: gameBoard);
    startingScreen();
  }

  final Ref ref;
  //local variables
  Timer? gameLoopTimer;
  //create the next piece
  Piece nextPiece =
      Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);

  late Piece currentPiece;
  int currentScore = 0;

  @override
  void dispose() {
    gameLoopTimer?.cancel();
    AudioPlayer().dispose();
    super.dispose();
  }

//start the game loop and reset
  void startGame() async {
    state = state.copyWith(disableButton: true);
    final level = ref.read(gameLevelProvider);
    await ref.read(levelBoardProvider.notifier).gameLevel(level);

    final sound = ref.read(soundProvider);
    if (sound) {
      await AudioPlayer().play(AssetSource('initialsetup.mp3'), volume: 0.3);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    //get the refresh rate from the speed level provider and set the refresh rate
    final refreshTime = ref.read(speedLevelProvider.notifier).getRefreshRate;
    state = state.copyWith(isPlaying: true, disableButton: false);
    //initialize the board
    currentScore = 0;
    final levelBoard = deepCopyBoard(ref.read(levelBoardProvider).gameBoard);
    gameBoard = deepCopyBoard(levelBoard);
    state = state.copyWith(
        gameBoard: gameBoard, currentScore: currentScore, gameOver: false);
    //create empty board
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
    //loop the game every
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
    currentScore = 0;
    gameBoard = deepCopyBoard(emptyGameBoard);
    state = state.copyWith(
        gameBoard: gameBoard,
        currentScore: currentScore,
        gameOver: false,
        isPaused: false,
        currentPiece: currentPiece.initializePiece());

    // Cancel the previous timer if it exists
    gameLoopTimer?.cancel();
    startingScreen();
    // createNewPiece();
    // startGame();
  }

  //Functions To detect collisions
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
        if (row >= 0 && col >= 0 && col < maxCol) {
          if (gameBoard[row][col] != null) {
            return true;
          }
        }
      } else if (direction == Direction.right) {
        col++;
        //check if right place is occipied
        if (row >= 0 && col >= 0 && col < maxCol) {
          if (gameBoard[row][col] != null) {
            return true;
          }
        }
      }
      //check if the piece is at the ends of the board and left right movements can be done or not
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
      currentScore += 20;
      state = state.copyWith(currentScore: currentScore);
      //create new piece after landing
      createNewPiece();
    }
  }

  void clearLine() async {
    int clear = 0;
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
        clear++;
        final audio = ref.read(soundProvider);
        if (audio) {
          AudioPlayer().play(AssetSource('fastsweep.wav'), volume: 1);
        }
        //show clear animation

        for (int col = 0; col < maxCol; col++) {
          await _clearCell(row, col, 3);
        }
        //move the pieces down row by row
        for (int i = row; i > 0; i--) {
          gameBoard[i] = List.from(gameBoard[i - 1]);
        }
        //set the top row to null
        gameBoard[0] = List.generate(maxCol, (col) => null);
        //increase the score by 100
        //
        currentScore += 100;
        state = state.copyWith(currentScore: currentScore);
      }
    }
    int delay = clear * 8;
    Future.delayed(Duration(milliseconds: delay));
  }

  void createNewPiece() async {
    currentPiece = nextPiece.copyWith().initializePiece();
    //create new random piece
    Random ran = Random();
    Tetromino newShape = Tetromino.values[ran.nextInt(Tetromino.values.length)];
    nextPiece = Piece(shape: newShape);
    state = state.copyWith(nextPiece: nextPiece);
//check if the game is over
    if (await isGameOver()) {
      gameLoopTimer?.cancel();
      updateHighScore();
      state = state.copyWith(isPlaying: false);
      await createGameOverDisplay();
      // state = state.copyWith(gameOver: true);
      // showGameOverMessage();
    }
  }

  //Check if GAmeOver
  Future<bool> isGameOver() async {
    //if the piece is at the top of the board
    final sound = ref.read(soundProvider);
    for (int col = 0; col < maxCol; col++) {
      if (gameBoard[0][col] != null) {
        if (sound) {
          await AudioPlayer().play(AssetSource('gameover1.mp3'), volume: 1);
        }
        return true;
      }
    }
    return false;
  }

  //update the high score if new high score is achieved
  void updateHighScore() {
    final highScore = ref.read(highScoreProvider.notifier);
    highScore.saveHighScore(state.currentScore);
  }

  //setting functions for controlling features of the game
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

  //functions to control movement and orientation of piece
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

//Fuctions to drop teh piece
  void dropPiece() async {
    if (!state.isPaused) {
      //  Keep moving the piece down until it collides or reaches the bottom

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

  //Display animated grids

  //animation for the Game over
  //create the game over display
  Future<void> createGameOverDisplay() async {
    // print('UTSAB: EMPTY $emptyGameBoard');
    // print('UTSAB: GAME $gameBoard');
    // print('UTSAB: STATE (${state.gameBoard})');
    // state = state.copyWith(gameBoard: emptyGameBoard);
    // final audioplayer = AudioPlayer();

    //clears the current piece
    state = state.copyWith(
        currentPiece: currentPiece.initializePiece(), disableButton: true);
    //clear the screen first with animation
    for (int row = 0; row < maxRow; row++) {
      for (int col = 0; col < maxCol; col++) {
        if (state.gameBoard[row][col] != null) {
          await _clearCell(row, col, 2);
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
    state = state.copyWith(
      gameOver: true,
      disableButton: false,
    );
  }

//fuction to fill the cell in board
  Future<void> _fillCell(int row, int col) async {
    //replace tetromino with current piece
    state.gameBoard[row][col] = state.currentPiece.shape;
    state = state.copyWith(); // Update the state to trigger UI update
    await Future.delayed(
        const Duration(milliseconds: 3)); // Delay between cells
  }

  //function to clear the cell in board
  Future<void> _clearCell(int row, int col, int time) async {
    state.gameBoard[row][col] = null; // Clear the cell
    state = state.copyWith(); // Update the state to trigger UI update
    await Future.delayed(Duration(milliseconds: time)); // Delay between cells
  }

  //create the starting screen of the game
  //Animation for Start up display
  //function to create the starting screen
  Future<void> startingScreen() async {
    final sound = ref.read(soundProvider);
    if (sound) {
      await AudioPlayer().play(AssetSource('initialsetup.mp3'), volume: 0.6);
    }

    gameBoard = deepCopyBoard(emptyGameBoard);
    state = state.copyWith(
      currentPiece: state.currentPiece.initializePiece(),
      gameBoard: gameBoard,
      isPlaying: false,
      isPaused: false,
      gameOver: false,
      disableButton: true,
    );

    //take a pause after a letter is displayed
    await Future.delayed(const Duration(milliseconds: 600));

    // Fill rows below row 4 randomly
    for (int row = maxRow - 1; row >= 5; row--) {
      await _fillRowRandomly(row);
    }
    if (sound) {
      await AudioPlayer().play(AssetSource('reset.wav'), volume: 0.9);
    }
    // Fill rows 2, 3, and 4
    for (int col = 0; col < maxCol; col++) {
      if (col == 2 || col == 4 || col == 7) {
        await Future.delayed(const Duration(milliseconds: 150));
      }
      await _fillRowAlternating(col);
    }
    //enable buttons
    state = state.copyWith(disableButton: false);
  }

  Future<void> _fillRowRandomly(int row) async {
    for (int col = 0; col < maxCol; col++) {
      state.gameBoard[row][col] = initialBoard[row][col]; // Set the piece
      state = state.copyWith(); // Update the state to trigger UI update
      await Future.delayed(
          const Duration(milliseconds: 2)); // Delay between cells
    }
  }

  Future<void> _fillRowAlternating(int col) async {
    for (int row = 4; row > 1; row--) {
      state.gameBoard[row][col] = initialBoard[row][col]; // Set the piece
      state = state.copyWith();
      await Future.delayed(
          const Duration(milliseconds: 5)); // Delay between cells
    }
  }
}
