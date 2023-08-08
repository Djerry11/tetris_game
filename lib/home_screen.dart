import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/buttons/cutom_button.dart';
import 'package:tetris_game/resources/button_colors.dart';
import 'package:tetris_game/resources/button_size.dart';
import 'package:tetris_game/tetris_board.dart';
import 'package:tetris_game/tetromino_pieces.dart';
import 'package:tetris_game/values.dart';
import 'package:vibration/vibration.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  maxRow,
  (row) => List.generate(maxCol, (col) => null),
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isPaused = false;
  bool vibrate = true;
  Timer? gameLoopTimer;
  Piece nextPiece =
      Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);
  //assign the current piece to the next piece
  late Piece currentPiece;
  //set current score to 0 initially
  int currentScore = 0;

  //bool to check if the game is over
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece = nextPiece;
    // Identify the shape of the current piece
    currentPiece.initializePiece();

    nextPiece = Piece(
        shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);

    // Cancel the previous timer if it exists
    gameLoopTimer?.cancel();

    // Screen refresh time
    Duration frameRefreshRate = const Duration(milliseconds: 800);

    // Start the new game loop timer
    gameLoopTimer = loopGame(frameRefreshRate);
  }

//create piece and loop the game
  //refresh the screen periodically
  Timer loopGame(Duration frameRefreshRate) {
    return Timer.periodic(
      frameRefreshRate,
      (timer) {
        if (!isPaused) {
          setState(() {
            clearLine();
            checkLanding();
            if (gameOver) {
              timer.cancel();
              showGameOverMessage();
            }
            currentPiece.movePiece(Direction.down);
          });
        }
      },
    );
  }

  //check for the collision of the pieces with the board
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

  //check if the piece is at the ends of the board
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
      //create new piece after landing
      createNewPiece();
    }
  }

//create new piece after landing
  void createNewPiece() {
    currentPiece = nextPiece;
    //create new random piece
    Random ran = Random();
    Tetromino newShape = Tetromino.values[ran.nextInt(Tetromino.values.length)];
    nextPiece = Piece(shape: newShape);
    currentPiece.initializePiece();
    //check if the game is over
    if (isGameOver()) {
      gameOver = true;
    }
  }

//move the piece in the left direction
  void moveLeft() {
    if (!isPaused) {
      if (!checkCollisions(Direction.left)) {
        setState(() {
          currentPiece.movePiece(Direction.left);
        });
      }
    }
  }

//move the piece in the right direction
  void moveRight() {
    if (!isPaused) {
      if (!checkCollisions(Direction.right)) {
        setState(() {
          currentPiece.movePiece(Direction.right);
        });
      }
    }
  }

//change the orientation of the piece
  void rotatePiece() {
    if (!isPaused) {
      setState(() {
        currentPiece.rotatePiece();
      });
    }
  }

  //clear the lines if full
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
        setState(() {
          currentScore += 500;
        });
      }
    }
  }

//check if the game is over
  bool isGameOver() {
    //if the piece is at the top of the board
    for (int col = 0; col < maxCol; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

//show alert dialog box when game is over
  void showGameOverMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your Score is: $currentScore'),
          actions: [
            TextButton(
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            )
          ],
        );
      },
    );
  }

//pause the game
  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void confirmReset() {
    togglePause();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Game'),
          content: const Text('Do you want to restart the game?'),
          actions: [
            TextButton(
              onPressed: () {
                togglePause();
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                togglePause();
                resetGame();
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    gameBoard =
        List.generate(maxRow, (row) => List.generate(maxCol, (col) => null));
    gameOver = false;
    currentScore = 0;

    // Cancel the previous timer if it exists
    gameLoopTimer?.cancel();

    createNewPiece();
    startGame();
  }

  //dropt the piece instantly
  void dropPiece() {
    if (!isPaused) {
      setState(() {
        // Keep moving the piece down until it collides or reaches the bottom
        while (!checkCollisions(Direction.down)) {
          currentPiece.movePiece(Direction.down);
        }
        // Handle landing and create a new piece
        checkLanding();
      });
    }
  }

  //drop the piece by steps
  void dropPieceBySteps(int steps) {
    if (!isPaused) {
      setState(() {
        // Move the piece down by the specified number of steps
        for (int i = 0; i < steps; i++) {
          if (!checkCollisions(Direction.down)) {
            currentPiece.movePiece(Direction.down);
          } else {
            break;
          }
        }
        // Handle landing and create a new piece
        checkLanding();
      });
    }
  }

  void toggleVibrate() {
    setState(() {
      vibrate = !vibrate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.blueGrey.shade600;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //Display Screen for the game
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),

              //Display Screen for the game TetrisBoard ,scores,level,lines,next piece
              child: Container(
                height: height * 0.478,
                width: width * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 2,
                  ),
                  color: Colors.green.shade50,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.51,
                      width: width * 0.46,
                      child: TetrisBoard(
                        currentPiece: currentPiece,
                        gameBoard: gameBoard,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Score: ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              '$currentScore',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //Setting/options buttons list tiny buttons
            ClipRRect(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                child: ClipRect(
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.4,
                      ),
                      //list of options tiny buttons
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Reset Button
                          CustomButton(
                            onPressed: () async {
                              if (vibrate) {
                                await Vibration.vibrate(
                                    duration: 50, amplitude: 22);
                              }
                              confirmReset();
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().resetButton,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //Pause Button/playbutton
                          CustomButton(
                            onPressed: () async {
                              togglePause();
                              if (vibrate) {
                                await Vibration.vibrate(
                                    duration: 50, amplitude: 22);
                              }
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().tinyButton,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //Sound/vibrate Button
                          CustomButton(
                            onPressed: () async {
                              toggleVibrate();
                              if (vibrate) {
                                await Vibration.vibrate(
                                    duration: 50, amplitude: 22);
                              }
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().tinyButton,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //Options Button
                          CustomButton(
                            onPressed: () async {
                              if (vibrate) {
                                await Vibration.vibrate(
                                    duration: 50, amplitude: 22);
                              }
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().tinyButton,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Game control buttons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 30, 25),
                    child: SizedBox(
                        width: width * 0.5,
                        height: double.infinity,
                        //  color: _backgroundColor,
                        //movement controll buttons
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //up button//drop down instantly
                            CustomButton(
                              onPressed: () async {
                                dropPiece();
                                if (vibrate) {
                                  await Vibration.vibrate(
                                    duration: 50,
                                    amplitude: 22,
                                  );
                                }
                              },
                              buttonSize: ButtonSize().controlButton,
                              colors: ButtonColors().controlButton,
                            ),
                            //left and right buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //left button
                                CustomButton(
                                  onPressed: () async {
                                    moveLeft();
                                    if (vibrate) {
                                      await Vibration.vibrate(
                                        duration: 50,
                                        amplitude: 22,
                                      );
                                    }
                                  },
                                  buttonSize: ButtonSize().controlButton,
                                  colors: ButtonColors().controlButton,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                //right button
                                CustomButton(
                                  onPressed: () async {
                                    moveRight();
                                    if (vibrate) {
                                      await Vibration.vibrate(
                                        duration: 50,
                                        amplitude: 22,
                                      );
                                    }
                                  },
                                  buttonSize: ButtonSize().controlButton,
                                  colors: ButtonColors().controlButton,
                                ),
                              ],
                            ),
                            //down button
                            CustomButton(
                              onPressed: () {
                                if (vibrate) {
                                  Vibration.vibrate(
                                    duration: 50,
                                    amplitude: 22,
                                  );
                                }
                                dropPieceBySteps(2);
                              },
                              buttonSize: ButtonSize().controlButton,
                              colors: ButtonColors().controlButton,
                            ),
                          ],
                        )),
                  ),
                  //main button /Rotate button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 40),
                    child: SizedBox(
                      width: width * 0.35,
                      height: double.infinity,
                      //  color: _backgroundColor,
                      child: Center(
                          //Rotate Buttonf
                          child: CustomButton(
                        onPressed: () async {
                          rotatePiece();
                          if (vibrate) {
                            await Vibration.vibrate(
                              duration: 50,
                              amplitude: 22,
                            );
                          }
                        },
                        buttonSize: ButtonSize().mainButton,
                        colors: ButtonColors().mainButton,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
