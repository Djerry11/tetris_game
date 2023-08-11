import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/providers/game_control_provider.dart';
import 'package:tetris_game/providers/individual_provider.dart';

import 'package:tetris_game/resources/values.dart';

//initialize board with null values

class TetrisBoard extends StatelessWidget {
  const TetrisBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //building the background of the board

    return Consumer(builder: (context, ref, child) {
      final gameState = ref.watch(gameController);
      final gameBoard = gameState.gameBoard;
      final currentPiece = gameState.currentPiece;

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
          if (currentPiece.position.contains(index)) {
            return Consumer(builder: (context, ref, child) {
              final colorMode = ref.watch(pieceColorProvider);
              return colorMode
                  ? Pixel(
                      colors: currentPiece.color,
                    )
                  : Pixel(colors: PieceColor().activePiece);
            });
          } else if (gameBoard[row][col] != null) {
            //display shape of landed piece in board
            final Tetromino? shape = gameBoard[row][col];
            return Consumer(builder: (context, ref, child) {
              final colorMode = ref.watch(pieceColorProvider);
              return colorMode
                  ? Pixel(
                      colors: tetrominoColor[shape]!,
                    )
                  : Pixel(colors: PieceColor().activePiece);
            });

            //  colorMode.isColor
            //     ? Pixel(
            //         colors: tetrominoColor[shape]!,
            //       )
            //     : Pixel(colors: PieceColor().activePiece);
          } else {
            //display empty grid
            return Pixel(
              colors: PieceColor().bgPiece,
            );
          }
        },
      );
    });
  }
}
