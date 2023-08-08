import 'package:flutter/material.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/resources/button_colors.dart';
import 'package:tetris_game/resources/values.dart';
import 'package:tetris_game/tetromino_pieces.dart';

class SideScreen extends StatelessWidget {
  const SideScreen({
    super.key,
    required this.currentScore,
    required this.nextPiece,
    required this.pause,
    required this.vibrate,
  });
  final bool pause;
  final int currentScore;
  final Piece nextPiece;
  final bool vibrate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
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
              const SizedBox(
                height: 60,
              ),
              //display next piece
              const Text(
                'Next :',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black26,
                    width: 1,
                  ),
                ),
                width: 80,
                height: 40,
                child: GridView.builder(
                  itemCount: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    nextPiece.initializeNextPiece();
                    if (nextPiece.position.contains(index)) {
                      return Pixel(colors: tetrominoColor[nextPiece.shape]!);
                    } else {
                      return Pixel(
                        colors: PieceColor().bgPiece,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          pause
              ? const Column(
                  children: [
                    Text(
                      'Paused',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black38,
                      size: 30,
                    )
                  ],
                )
              : Container(),
          vibrate
              ? const Column(
                  children: [
                    Text(
                      'Vibration on',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Icon(
                      Icons.vibration,
                      color: Colors.black38,
                      size: 30,
                    )
                  ],
                )
              : const Column(
                  children: [
                    Text(
                      'Vibration off',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Icon(
                      Icons.notifications_off,
                      color: Colors.black38,
                      size: 30,
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
