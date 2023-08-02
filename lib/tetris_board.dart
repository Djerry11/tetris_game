import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/tetromino_pieces.dart';
import 'package:tetris_game/values.dart';

//create the main background grid for game
class TetrisBoard extends StatefulWidget {
  const TetrisBoard({super.key});

  @override
  State<TetrisBoard> createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  Piece currentPiece = Piece(shape: Tetromino.L);

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
    updateBoard(frameRefreshRate);
  }

  void updateBoard(Duration frameRefreshRate) {
    Timer.periodic(frameRefreshRate, (timer) {
      setState(() {
        //move the piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  bool checkEndPoint(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and column of the piece in board
      int row = (currentPiece.position[i] / maxRow).floor();
      int col = currentPiece.position[i] % maxRow;
      //calculate the next position of the piece in board
      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.left) {
        col--;
      } else if (direction == Direction.right) {
        col++;
      }
      //check if the piece is at the ends of the board
      if (col < 0 || row >= maxCol || col >= maxRow) {
        return true;
      }
    }
    //if the piece is not at the ends of the board
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //building the background of the board
      body: GridView.builder(
        itemCount: maxRow * maxCol,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: maxRow,
        ),
        itemBuilder: (context, index) {
          //display shape of current piece in board
          if (currentPiece.position.contains(index)) {
            return Pixel(
              color: Colors.red,
              index: index,
            );
          } else {
            //display empty grid
            return Pixel(
              color: Colors.grey[850],
              index: index,
            );
          }
          //child: Text(index.toStr ing()),
        },
      ),
    );
  }
}
