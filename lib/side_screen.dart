import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/pixel.dart';

import 'package:tetris_game/providers/game_control_provider.dart';
import 'package:tetris_game/providers/individual_provider.dart';
import 'package:tetris_game/resources/values.dart';

class SideScreen extends StatelessWidget {
  const SideScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Consumer(builder: (context, ref, child) {
                  final currentScore = ref.watch(scoreProvider);

                  return Text(
                    '$currentScore',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  );
                }),
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
              child: Consumer(builder: (context, ref, child) {
                final nextPiece =
                    ref.watch(nextPieceProvider).initializeNextPiece();
                return GridView.builder(
                  itemCount: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    if (nextPiece.position.contains(index)) {
                      return Consumer(
                        builder: (context, ref, child) {
                          final colorMode = ref.watch(pieceColorProvider);
                          return colorMode
                              ? Pixel(
                                  colors: tetrominoColor[nextPiece.shape]!,
                                )
                              : Pixel(
                                  colors: PieceColor().activePiece,
                                );
                        },
                      );
                    } else {
                      return Pixel(
                        colors: PieceColor().bgPiece,
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Consumer(
          builder: (context, ref, child) {
            final gameProvider = ref.watch(gameController);
            return gameProvider.isPaused
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
                : Container();
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(vibrationProvider)
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
                  );
          },
        ),
      ],
    );
  }
}
