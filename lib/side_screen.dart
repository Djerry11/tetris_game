import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
        const SizedBox(
          height: 10,
        ),
        const DisplayScore(
          title: 'HI-SCORE',
        ),
        const SizedBox(
          height: 20,
        ),
        const DisplayScore(title: 'SCORE'),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Next ',
          textAlign: TextAlign.center,
          style: GoogleFonts.vt323(
            textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const NextPieceDisplay(),
        const SizedBox(
          height: 15,
        ),
        Consumer(
          builder: (context, ref, child) {
            final gameProvider = ref.watch(gameController);
            return Visibility(
              visible: gameProvider.isPaused,
              child: Column(
                children: [
                  Text(
                    'Paused',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vt323(
                      textStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.black38,
                    size: 30,
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 15,
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
                          fontSize: 16,
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
                          fontSize: 16,
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

class DisplayScore extends StatelessWidget {
  const DisplayScore({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.vt323(
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Consumer(builder: (context, ref, child) {
          final currentScore = title == 'SCORE'
              ? ref.watch(scoreProvider)
              : ref.watch(highScoreProvider);
          return Text(
            currentScore == 0 ? '000000' : currentScore.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.vt323(
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
            ),
          );
        }),

        //display next piece
      ],
    );
  }
}

class NextPieceDisplay extends StatelessWidget {
  const NextPieceDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        final nextPiece = ref.watch(nextPieceProvider).initializeNextPiece();
        return GridView.builder(
          itemCount: 8,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 0, crossAxisSpacing: 0),
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
    );
  }
}
