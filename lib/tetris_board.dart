import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_game/grid_pixel.dart';
import 'package:tetris_game/tetromino_pieces.dart';
import 'package:tetris_game/values.dart';

//initialize board with null values
List<List<Tetromino?>> newBoard = List.generate(
  maxRow,
  (row) => List.generate(maxCol, (col) => null),
);

class TetrisBoard extends StatefulWidget {
  const TetrisBoard({super.key});

  @override
  State<TetrisBoard> createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  Piece currentPiece =
      Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    //identify the shape of current piece
    currentPiece.initializePiece();

    //screen refresh time
    Duration frameRefreshRate = const Duration(milliseconds: 300);
    loopGame(frameRefreshRate);
  }

  void loopGame(Duration frameRefreshRate) {
    Timer.periodic(
      frameRefreshRate,
      (timer) {
        setState(() {
          //check if the piece is at the ends of the board
          checkLanding();
          //move the piece down
          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  bool checkEndPoint(Direction direction) {
    //check if the piece can move in the direction
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and column of the piece in board
      int row = (currentPiece.position[i] / maxCol).floor();
      int col = currentPiece.position[i] % maxCol;
      //calculate the next position of the piece in board
      if (row + 1 < maxRow && row >= 0 && newBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }

      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.left) {
        col--;
      } else if (direction == Direction.right) {
        col++;
      }
      //check if the piece is at the ends of the board
      if (col < 0 || row >= maxRow || col >= maxCol) {
        return true;
      }
    }
    //if the piece is not at the ends of the board
    return false;
  }

  void checkLanding() {
    if (checkEndPoint(Direction.down)) {
      //stop the piece from moving
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / maxCol).floor();
        int col = currentPiece.position[i] % maxCol;
        if (row >= 0 && col >= 0) {
          newBoard[row][col] = currentPiece.shape;
        }
      }
      //create new piece after landing
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create new random piece
    Random ran = Random();
    Tetromino newShape = Tetromino.values[ran.nextInt(Tetromino.values.length)];
    currentPiece = Piece(shape: newShape);
    currentPiece.initializePiece();
  }

//move the piece in the direction
  void moveLeft() {
    if (!checkEndPoint(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkEndPoint(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
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
                    color: Colors.red,
                    index: index,
                  );
                } else if (newBoard[row][col] != null) {
                  //display shape of landed piece in board
                  return GridPixel(
                    color: Colors.green,
                    index: index,
                  );
                } else {
                  //display empty grid
                  return GridPixel(
                    color: Colors.grey[850],
                    index: index,
                  );
                }
              },
            ),
          ),
          Row(
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
                onPressed: () {},
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
              IconButton(
                onPressed: moveRight,
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          )
        ],
      ),
    );
  }
}
