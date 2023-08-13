import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tetris_game/buttons/cutom_button.dart';
import 'package:tetris_game/gameover.dart';

import 'package:tetris_game/providers/game_control_provider.dart';
import 'package:tetris_game/providers/individual_provider.dart';
import 'package:tetris_game/resources/button_colors.dart';
import 'package:tetris_game/resources/button_size.dart';
import 'package:tetris_game/side_screen.dart';
import 'package:tetris_game/tetris_board.dart';

import 'package:vibration/vibration.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as shadow;

// Import this line

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

//   bool changeColor = false;
  @override
  Widget build(BuildContext context) {
    const duration = 30;
    const amplitude = 15;

    const backgroundColor = Color.fromARGB(255, 77, 132, 141);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Consumer(builder: (context, ref, child) {
            final gradient = ref.watch(gradientProvider);
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient,
                ),
              ),
            );
          }),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Display Screen for the game
                  Padding(
                    padding: const EdgeInsets.only(top: 40),

                    //Display Screen for the game TetrisBoard ,scores,level,lines,next piece
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: const shadow.BoxDecoration(
                            boxShadow: [
                              shadow.BoxShadow(
                                color: Color.fromARGB(255, 34, 15, 2),
                                blurRadius: 8,
                                blurStyle: BlurStyle.inner,
                                offset: Offset(-6, -6),
                                inset: true,
                              ),
                              shadow.BoxShadow(
                                  color: Color.fromARGB(255, 34, 15, 2),
                                  blurRadius: 8,
                                  blurStyle: BlurStyle.outer,
                                  offset: Offset(6, 6),
                                  inset: true),
                            ],
                          ),
                          height: height * 0.52,
                          width: width * 0.78,
                        ),
                        Container(
                          height: height * 0.467,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(115, 20, 19, 19),
                              width: 4,
                            ),
                            color: Colors.green.shade50,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 2,
                                      ),
                                    ),
                                    height: height * 0.522,
                                    width: width * 0.46,
                                    child: const TetrisBoard(),
                                  ),
                                  Consumer(builder: (context, ref, child) {
                                    return Visibility(
                                        visible:
                                            ref.watch(gameController).gameOver,
                                        child: Positioned(
                                          top: height * 0.08,
                                          child: SizedBox(
                                              width: width * 0.45,
                                              child: const GameOverScreen()),
                                        ));
                                  })
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 219, 229, 216),
                                ),
                                height: height * 0.51,
                                width: width * 0.20,
                                child: const SideScreen(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //Setting/options buttons list tiny buttons
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.43,
                        ),
                        //list of options tiny buttons
                        Consumer(builder: (context, ref, child) {
                          final gameState = ref.watch(gameController);
                          final vibrate = ref.watch(vibrationProvider);
                          final isPaused = gameState.isPaused;
                          final isPlaying = gameState.isPlaying;

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //Reset Button

                              CustomButton(
                                onPressed: () {
                                  if (vibrate) {
                                    Vibration.vibrate(
                                      duration: duration,
                                      amplitude: amplitude,
                                    );
                                  }
                                  ref.read(gameController.notifier).resetGame();
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().resetButton,
                                buttonName: 'Reset',
                                textColor:
                                    const Color.fromARGB(255, 225, 31, 17),
                              ),

                              const SizedBox(
                                width: 15,
                              ),
                              //Pause Button/playbutton
                              CustomButton(
                                  onPressed: () {
                                    ref
                                        .read(gameController.notifier)
                                        .togglePause();
                                    if (vibrate) {
                                      Vibration.vibrate(
                                          duration: amplitude,
                                          amplitude: duration);
                                    }
                                  },
                                  buttonSize: ButtonSize().tinyButton,
                                  colors: ButtonColors().tinyButton,
                                  buttonName: isPlaying
                                      ? isPaused
                                          ? 'Play'
                                          : 'Pause'
                                      : 'Option'),
                              const SizedBox(
                                width: 15,
                              ),
                              //Sound/vibrate Button
                              CustomButton(
                                onPressed: () {
                                  ref
                                      .read(vibrationProvider.notifier)
                                      .toggleVibration();

                                  if (vibrate) {
                                    Vibration.vibrate(
                                        duration: duration,
                                        amplitude: amplitude);
                                  }
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().tinyButton,
                                buttonName: 'Vibrate ',
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              //Options Button for sound control
                              CustomButton(
                                onPressed: () {
                                  ref
                                      .read(soundProvider.notifier)
                                      .toggleSound();
                                  if (vibrate) {
                                    Vibration.vibrate(
                                        duration: duration,
                                        amplitude: amplitude);
                                  }
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().tinyButton,
                                buttonName: 'Sound',
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),

                  //Game control buttons

                  //moveent control buttons with different options in differen conditions
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          final gameState = ref.watch(gameController);
                          final vibrate = ref.watch(vibrationProvider);
                          final sound = ref.watch(soundProvider);
                          final isPaused = gameState.isPaused;
                          final isPlaying = gameState.isPlaying;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child: SizedBox(
                              width: width * 0.5,

                              //  color: _backgroundColor,
                              //movement controll buttons
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //up button//drop down instantly
                                    //increase the speed of the game
                                    CustomButton(
                                      onPressed: () {
                                        if (!isPlaying) {
                                          ref
                                              .read(speedLevelProvider.notifier)
                                              .increaseSpeedLeve();
                                        }
                                        if (isPlaying && !isPaused) {
                                          if (sound) {
                                            AudioPlayer().play(
                                                AssetSource('instantdrop.wav'),
                                                volume: 0.3);
                                          }
                                          ref
                                              .read(gameController.notifier)
                                              .dropPiece();
                                        }
                                        if (vibrate) {
                                          Vibration.vibrate(
                                            duration: duration,
                                            amplitude: amplitude,
                                          );
                                        }
                                      },
                                      buttonSize: ButtonSize().controlButton,
                                      colors: ButtonColors().controlButton,
                                    ),
                                    //left and right buttons
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //left button for left movement
                                        // also control the background color if paused
                                        //decrese level if not playing and not paused
                                        CustomButton(
                                          onPressed: () {
                                            isPaused
                                                ? ref
                                                    .read(gradientProvider
                                                        .notifier)
                                                    .toggleBack()
                                                : !isPlaying
                                                    ? ref
                                                        .read(gameLevelProvider
                                                            .notifier)
                                                        .decreaseGameLevel()
                                                    : ref
                                                        .read(gameController
                                                            .notifier)
                                                        .moveLeft();
                                            if (vibrate) {
                                              Vibration.vibrate(
                                                duration: duration,
                                                amplitude: amplitude,
                                              );
                                            }
                                          },
                                          buttonSize:
                                              ButtonSize().controlButton,
                                          colors: ButtonColors().controlButton,
                                        ),
                                        const SizedBox(
                                          width: 60,
                                        ),
                                        //right button
                                        //change theme if paused else move right
                                        //increase game level if not playing and not paused
                                        CustomButton(
                                          onPressed: () {
                                            isPaused
                                                ? ref
                                                    .read(gradientProvider
                                                        .notifier)
                                                    .toggleBackground()
                                                : isPlaying
                                                    ? ref
                                                        .read(gameController
                                                            .notifier)
                                                        .moveRight()
                                                    : ref
                                                        .read(gameLevelProvider
                                                            .notifier)
                                                        .increaseGameLevel();
                                            if (vibrate) {
                                              Vibration.vibrate(
                                                duration: duration,
                                                amplitude: amplitude,
                                              );
                                            }
                                          },
                                          buttonSize:
                                              ButtonSize().controlButton,
                                          colors: ButtonColors().controlButton,
                                        ),
                                      ],
                                    ),
                                    //down button
                                    //decrease the speed level of the game if game is not playing
                                    CustomButton(
                                      onPressed: () {
                                        if (!isPlaying) {
                                          ref
                                              .read(speedLevelProvider.notifier)
                                              .decreaseSpeedLevel();
                                        }
                                        if (isPlaying && !isPaused) {
                                          ref
                                              .read(gameController.notifier)
                                              .dropPieceBySteps(2);
                                        }
                                        if (vibrate) {
                                          Vibration.vibrate(
                                            duration: duration,
                                            amplitude: amplitude,
                                          );
                                        }
                                      },
                                      buttonSize: ButtonSize().controlButton,
                                      colors: ButtonColors().controlButton,
                                    ),
                                    Visibility(
                                      visible: (isPaused || !isPlaying),
                                      child: Text(
                                          (isPaused)
                                              ? (isPlaying)
                                                  ? '< Change Theme >\n '
                                                  : '  Change Speed \n< Change Theme > '
                                              : '  Change Speed \n< Change Level >',
                                          style: GoogleFonts.adventPro(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepOrangeAccent)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        //main button /Rotate button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 60, 10, 40),
                          child: SizedBox(
                            width: width * 0.35,
                            height: double.infinity,
                            //  color: _backgroundColor,
                            child: Center(
                              child: Consumer(builder: (context, ref, child) {
                                final gameState = ref.watch(gameController);

                                final vibrate = ref.watch(vibrationProvider);
                                final isPaused = gameState.isPaused;

                                ///for the initial start of the game to display the main button as start button
                                // if paused used as color toggleer
                                return (gameState.isPlaying && !isPaused)
                                    ? CustomButton(
                                        type: 'main',
                                        onPressed: () {
                                          ref
                                              .read(gameController.notifier)
                                              .rotatePiece();
                                          if (vibrate) {
                                            Vibration.vibrate(
                                              duration: duration,
                                              amplitude: amplitude,
                                            );
                                          }
                                        },
                                        buttonSize: ButtonSize().mainButton,
                                        colors: ButtonColors().mainButton,
                                        buttonName: 'Rotate',
                                        textColor: Colors.amberAccent,
                                      )
                                    : CustomButton(
                                        type: 'main',
                                        onPressed: () {
                                          (isPaused)
                                              ? ref
                                                  .read(pieceColorProvider
                                                      .notifier)
                                                  .toggleColor()
                                              : ref
                                                  .read(gameController.notifier)
                                                  .startGame();

                                          if (vibrate) {
                                            Vibration.vibrate(
                                              duration: duration,
                                              amplitude: amplitude,
                                            );
                                          }
                                        },
                                        buttonSize: ButtonSize().mainButton,
                                        colors: ButtonColors().mainButton,
                                        buttonName: (!isPaused)
                                            ? 'Start'
                                            : 'Change ColorMode',
                                        textColor: const Color.fromARGB(
                                            255, 228, 57, 5),
                                      );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
