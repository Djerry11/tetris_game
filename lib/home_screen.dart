import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

import 'package:flutter_svg/flutter_svg.dart';

//Main Screen for the game
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
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  //Display Screen for the game
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: GameDisplay(height: height, width: width)),
                  const SizedBox(
                    height: 10,
                  ),

                  //Setting/options buttons list tiny buttons
                  SettingButtons(
                      width: width, duration: duration, amplitude: amplitude),

                  const SizedBox(
                    height: 18,
                  ), //Game control buttons
                  //movement control buttons with different options in different conditions
                  SizedBox(
                    height: 210,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        MovementControlButtons(
                            width: width,
                            duration: duration,
                            amplitude: amplitude),

                        const Spacer(
                          flex: 2,
                        ),
                        //main button /Rotate button
                        MainButton(
                            width: width,
                            duration: duration,
                            amplitude: amplitude),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Display Screen Simulated for the game
class GameDisplay extends StatelessWidget {
  const GameDisplay({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        visible: ref.watch(gameController).gameOver,
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
    );
  }
}

//Setting/options buttons list tiny buttons
class SettingButtons extends StatelessWidget {
  const SettingButtons({
    super.key,
    required this.width,
    required this.duration,
    required this.amplitude,
  });

  final double width;
  final int duration;
  final int amplitude;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.amber,
      height: 55,
      child: Consumer(builder: (context, ref, child) {
        final gameState = ref.watch(gameController);
        final vibrate = ref.watch(vibrationProvider);
        final isPaused = gameState.isPaused;
        final isPlaying = gameState.isPlaying;

        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Reset Button
            const SizedBox(
              width: 15,
            ),
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
              textColor: const Color.fromARGB(255, 225, 31, 17),
            ),

            const SizedBox(
              width: 15,
            ),
            //Pause Button/playbutton
            CustomButton(
                onPressed: () {
                  ref.read(gameController.notifier).togglePause();
                  if (vibrate) {
                    Vibration.vibrate(duration: amplitude, amplitude: duration);
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
                ref.read(vibrationProvider.notifier).toggleVibration();

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
                                onDoubleTap: () {
                                  ref
                                      .read(pieceColorProvider.notifier)
                                      .toggleColor();
                                  if (vibrate) {
                                    Vibration.vibrate(
                                        duration: duration,
                                        amplitude: amplitude);
                                  }
                                },
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
        ),
      ]);
    });
  }
}

//Movement Control Buttons //left,right,up,down
////change theme,change speed,change level
class MovementControlButtons extends StatelessWidget {
  const MovementControlButtons({
    super.key,
    required this.width,
    required this.duration,
    required this.amplitude,
  });

  final double width;
  final int duration;
  final int amplitude;

                  //moveent control buttons with different options in differen conditions
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          final gameState = ref.watch(gameController);
                          final vibrate = ref.watch(vibrationProvider);
                          final sound = ref.watch(soundProvider);
                          final isPaused = ref.watch(gameController).isPaused;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 30),
                            child: SizedBox(
                              width: width * 0.5,

                              //  color: _backgroundColor,
                              //movement controll buttons
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //up button//drop down instantly
                                  CustomButton(
                                    onPressed: () {
                                      if (!gameState.isPlaying) {
                                        ref
                                            .read(speedLevelProvider.notifier)
                                            .increaseSpeedLeve();
                                      }
                                      if (gameState.isPlaying && !isPaused) {
                                        if (sound) {
                                          AudioPlayer().play(
                                              AssetSource('instantdrop.wav'),
                                              volume: 0.5);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //left button for left movement
                                      // also control the background color if paused
                                      CustomButton(
                                        onPressed: () {
                                          isPaused
                                              ? ref
                                                  .read(
                                                      gradientProvider.notifier)
                                                  .toggleBack()
                                              : ref
                                                  .read(gameController.notifier)
                                                  .moveLeft();
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
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      //right button
                                      //change theme if paused else move right
                                      CustomButton(
                                        onPressed: () {
                                          isPaused
                                              ? ref
                                                  .read(
                                                      gradientProvider.notifier)
                                                  .toggleBackground()
                                              : ref
                                                  .read(gameController.notifier)
                                                  .moveRight();
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
                                    ],
                                  ),
                                  //down button
                                  //decrease the speed level of the game if game is not playing
                                  CustomButton(
                                    onPressed: () {
                                      if (!gameState.isPlaying) {
                                        ref
                                            .read(speedLevelProvider.notifier)
                                            .decreaseSpeedLevel();
                                      }
                                      if (gameState.isPlaying && !isPaused) {
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
                                      visible:
                                          (isPaused && gameState.isPlaying) ||
                                              isPaused,
                                      child: Text('< Change Theme >',
                                          style: GoogleFonts.adventPro(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepOrangeAccent)))
                                ],
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
                                return !isPaused
                                    ? CustomButton(
                                        type: 'main',
                                        onPressed: () {
                                          (!gameState.isPlaying)
                                              ? ref
                                                  .read(gameController.notifier)
                                                  .startGame()
                                              : ref
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
                                        buttonName: (!gameState.isPlaying)
                                            ? 'Start'
                                            : 'Rotate',
                                        textColor: const Color.fromARGB(
                                            255, 16, 206, 51),
                                      )
                                    : CustomButton(
                                        type: 'main',
                                        onPressed: () {
                                          ref
                                              .read(pieceColorProvider.notifier)
                                              .toggleColor();
                                          if (vibrate) {
                                            Vibration.vibrate(
                                              duration: duration,
                                              amplitude: amplitude,
                                            );
                                          }
                                        },
                                        buttonSize: ButtonSize().mainButton,
                                        colors: ButtonColors().mainButton,
                                        buttonName: 'Change Color',
                                        textColor: Colors.amberAccent,
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
            //For changing Theme left and right buttons
            //left
            ButtonLabel(
                label: 'Change',
                contition: (isPaused || (isPlaying && !isPlaying)),
                position: const [10, null, null, 56]),
            //right
            ButtonLabel(
                label: 'Theme',
                contition: (isPaused || (isPlaying && !isPlaying)),
                position: const [null, 8, null, 53]),
            //for changing speed //left and right buttons
            //left decerase speed
            ButtonLabel(
                label: 'Speed--',
                contition: (!isPaused && !isPlaying),
                position: const [0, null, null, 55]),
            //right increase speed
            ButtonLabel(
                label: 'Speed++',
                contition: (!isPaused && !isPlaying),
                position: const [null, 0, null, 55]),
            //for changing level //top and down buttons
            //down decrease level
            ButtonLabel(
                label: '   level--',
                contition: (isPaused && !isPlaying) ||
                    ((isPaused || !isPlaying) && !isPaused),
                position: const [null, null, null, 0]),
            //top increase level
            ButtonLabel(
                label: ' level++',
                contition: (isPaused && !isPlaying) ||
                    ((isPaused || !isPlaying) && !isPaused),
                position: const [null, null, 0, null]),
          ],
        ),
      );
    });
  }
}

//for displaying the label in the movement control buttons
class ButtonLabel extends StatelessWidget {
  const ButtonLabel({
    super.key,
    required this.label,
    required this.contition,
    required this.position,
  });
  final String label;
  final bool contition;
  final List<double?> position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position[0],
      right: position[1],
      top: position[2],
      bottom: position[3],
      child: Visibility(
        visible: contition,
        child: Text(label,
            style: const TextStyle(
                fontFamily: 'VT323',
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black)),
      ),
    );
  }
}
