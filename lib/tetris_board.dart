import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_game/grid_pixel.dart';
import 'package:tetris_game/tetromino_pieces.dart';
import 'package:tetris_game/values.dart';

//initialize board with null values
List<List<Tetromino?>> gameBoard = List.generate(
  maxRow,
  (row) => List.generate(maxCol, (col) => null),
);

class TetrisBoard extends StatefulWidget {
  const TetrisBoard({super.key});

  @override
  State<TetrisBoard> createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  Piece currentPiece = Piece(shape: Tetromino.I);

  //set current score to 0 initially
  int currentScore = 0;

  //bool to check if the game is over
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

//create piece and loop the game
  void startGame() {
    //identify the shape of current piece
    currentPiece.initializePiece();

    //screen refresh time
    Duration frameRefreshRate = const Duration(milliseconds: 300);
    loopGame(frameRefreshRate);
  }

  //refresh the screen periodically
  void loopGame(Duration frameRefreshRate) {
    //speed of the game
    Timer.periodic(
      frameRefreshRate,
      (timer) {
        setState(() {
          //check if the line can be cleared
          clearLine();
          //check if the piece is at the ends of the board
          checkLanding();
          //reset timer if game over
          if (gameOver) {
            timer.cancel();
            showGameOverMessage();
          }
          //move the piece down
          currentPiece.movePiece(Direction.down);
        });
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
      //create new piece after landing
      createNewPiece();
    }
  }

//create new piece after landing
  void createNewPiece() {
    //create new random piece
    Random ran = Random();
    Tetromino newShape = Tetromino.values[ran.nextInt(Tetromino.values.length)];
    currentPiece = Piece(shape: newShape);
    currentPiece.initializePiece();
    //check if the game is over
    if (isGameOver()) {
      gameOver = true;
    }
  }

//move the piece in the left direction
  void moveLeft() {
    if (!checkCollisions(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

//move the piece in the right direction
  void moveRight() {
    if (!checkCollisions(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

//change the orientation of the piece
  void rotPiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
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
          currentScore += 100;
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

  void showGameOverMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your Score is: $currentScore'),
          actions: [
            TextButton(
              onPressed: resetGame,
              child: const Text('Restart'),
            )
          ],
        );
      },
    );
  }

  void resetGame() {
    //reset all board pixels to null
    gameBoard =
        List.generate(maxRow, (row) => List.generate(maxCol, (col) => null));
    gameOver = false;
    currentScore = 0;
    //close the dialog box
    Navigator.of(context).pop();
    //create the new piece
    createNewPiece();
    //restart the game
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //building the background of the board
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: maxRow * maxCol,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: maxCol,
              ),
              itemBuilder: (context, index) {
                int row = (index / maxCol).floor();
                int col = index % maxCol;
                //display shape of current piece in board
                if (currentPiece.position.contains(index)) {
                  return GridPixel(
                    color: currentPiece.color,
                  );
                } else if (gameBoard[row][col] != null) {
                  //display shape of landed piece in board
                  final Tetromino? shape = gameBoard[row][col];
                  return GridPixel(
                    color: tetrominoColor[shape],
                  );
                } else {
                  //display empty grid
                  return GridPixel(
                    color: Colors.grey[850],
                  );
                }
              },
            ),
          ),
          //display the score
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              'Score: $currentScore',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: moveLeft,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                IconButton(
                  onPressed: rotPiece,
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
                IconButton(
                  onPressed: moveRight,
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
