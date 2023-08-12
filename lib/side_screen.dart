import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetris_game/models/piece_model.dart';
import 'package:tetris_game/pixel.dart';

import 'package:tetris_game/providers/game_control_provider.dart';
import 'package:tetris_game/providers/individual_provider.dart';
import 'package:tetris_game/resources/values.dart';

//main side screen for the game
class SideScreen extends StatelessWidget {
  const SideScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 1,
        ),
        const DisplayScore(
          title: 'HI-SCORE',
        ),
        const Spacer(
          flex: 1,
        ),
        const DisplayScore(title: 'SCORE'),
        const Spacer(
          flex: 1,
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
        const Spacer(
          flex: 2,
        ),
        const DisplayLevel(title: 'SPEED:'),
        const Spacer(
          flex: 4,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SettingIcon(
              icon: Icons.pause,
              // iconOff: Icons.pause,
              type: 'play',
            ),
            SettingIcon(
              icon: Icons.vibration,
              // iconOff: Icons.vibration_outlined,
              type: 'vibration',
            ),
            SettingIcon(
              icon: Icons.volume_up_sharp,
              //iconOff: Icons.volume_off_sharp,
              type: 'sound',
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

//Display various setting icons
class SettingIcon extends StatelessWidget {
  const SettingIcon({
    super.key,
    required this.icon,
    required this.type,
  });
  final IconData icon;

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        late final bool condition;
        switch (type) {
          case 'sound':
            condition = ref.watch(soundProvider);
            break;
          case 'vibration':
            condition = ref.watch(vibrationProvider);
            break;
          case 'play':
            condition = (ref.watch(gameController).isPaused &&
                ref.watch(gameController).isPlaying);
            break;
        }
        return condition
            ? Icon(
                icon,
                color: Colors.black87,
                size: 20,
              )
            : Icon(
                icon,
                color: Colors.black12,
                size: 20,
              );
      },
    );
  }
}

/// Method for displaying the score
/// //highScore and Score
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
          '$title :',
          style: const TextStyle(
              fontFamily: 'DSEG14',
              fontSize: 8,
              color: Colors.black87,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6),
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
            style: const TextStyle(
                fontFamily: 'DSEG14',
                fontSize: 8,
                color: Colors.black87,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6),
          );
        }),

        //display next piece
      ],
    );
  }
}

class DisplayLevel extends StatelessWidget {
  const DisplayLevel({
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
          '$title :',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            fontSize: 10,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Consumer(builder: (context, ref, child) {
          final currentLevel = ref.watch(speedLevelProvider);
          print('UTSAB : $currentLevel');
          return Text(
            currentLevel < 10 ? '0$currentLevel' : currentLevel.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: -1,
              fontSize: 15,
            ),
          );
        }),

        //display next piece
      ],
    );
  }
}

/// Method for displaying the next piece in the side screen
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
