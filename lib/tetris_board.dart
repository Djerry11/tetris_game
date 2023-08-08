import 'package:flutter/material.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/resources/button_colors.dart';
import 'package:tetris_game/tetromino_pieces.dart';
import 'package:tetris_game/resources/values.dart';

//initialize board with null values

class TetrisBoard extends StatefulWidget {
  const TetrisBoard({
    super.key,
    required this.currentPiece,
    required this.gameBoard,
  });
  final Piece currentPiece;
  final List<List<Tetromino?>> gameBoard;

  @override
  State<TetrisBoard> createState() => _TetrisBoardState();
}

class _TetrisBoardState extends State<TetrisBoard> {
  @override
  Widget build(BuildContext context) {
    //building the background of the board

    return GridView.builder(
      itemCount: maxRow * maxCol,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: maxCol, mainAxisSpacing: 0, crossAxisSpacing: 0),
      itemBuilder: (context, index) {
        int row = (index / maxCol).floor();
        int col = index % maxCol;
        //display shape of current piece in board
        if (widget.currentPiece.position.contains(index)) {
          return Pixel(
            colors: widget.currentPiece.color,
          );
        } else if (widget.gameBoard[row][col] != null) {
          //display shape of landed piece in board
          final Tetromino? shape = widget.gameBoard[row][col];
          return Pixel(
            colors: tetrominoColor[shape]!,
          );
        } else {
          //display empty grid
          return Pixel(
            colors: PieceColor().bgPiece,
          );
        }
      },
    );
  }
}
