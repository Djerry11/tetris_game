import 'package:flutter/material.dart';
import '../models/piece_model.dart';
import 'package:tetris_game/resources/values.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  // var piece = PieceHelper.initializePiece(Tetromino.L);
  // final nextPiece = PieceHelper.initializeNextPiece(Tetromino.L);

  @override
  Widget build(BuildContext context) {
    var piece = const Piece(shape: Tetromino.L).initializeNextPiece();
    piece = piece.rotatePiece();
    piece = piece.movePiece(Direction.down);

    // piece.movePiece(Direction.down);
    // piece.movePiece(Direction.down);

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            print(piece.position);
            piece = piece.rotatePiece();
          },
          child: const Text('Check'),
        ),
      ),
    );
  }
}
