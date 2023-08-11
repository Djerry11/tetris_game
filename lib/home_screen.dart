import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/buttons/control_button.dart';
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
    print('Utsab: HomeScreen: build()');
    const backgroundColor = Color.fromARGB(255, 77, 132, 141);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Consumer(builder: (context, ref, child) {
            print('Utsab: HomeScreen: Screen bAckground: builder()');
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
                          height: height * 0.478,
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
                                          top: height * 0.07,
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

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //Reset Button

                              CustomButton(
                                onPressed: () {
                                  if (vibrate) {
                                    Vibration.vibrate(
                                        duration: 50, amplitude: 22);
                                  }
                                  ref.read(gameController.notifier).resetGame();
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().resetButton,
                                buttonName: 'Reset',
                                textColor: Colors.red,
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
                                        duration: 50, amplitude: 22);
                                  }
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().tinyButton,
                                buttonName: isPaused ? 'Play' : 'Pause',
                              ),
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
                                        duration: 50, amplitude: 22);
                                  }
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().tinyButton,
                                buttonName: 'Vibrate ',
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              //Options Button
                              CustomButton(
                                onPressed: () {
                                  ref
                                      .read(gradientProvider.notifier)
                                      .toggleBackground();
                                  if (vibrate) {
                                    Vibration.vibrate(
                                        duration: 50, amplitude: 22);
                                  }
                                },
                                buttonSize: ButtonSize().tinyButton,
                                colors: ButtonColors().tinyButton,
                                buttonName: 'Options',
                                onDoubleTap: () {
                                  ref
                                      .read(pieceColorProvider.notifier)
                                      .toggleColor();
                                  if (vibrate) {
                                    Vibration.vibrate(
                                        duration: 50, amplitude: 22);
                                  }
                                },
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),

                  //Game control buttons
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          final gameState = ref.watch(gameController);
                          final vibrate = ref.watch(vibrationProvider);
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 40),
                            child: SizedBox(
                                width: width * 0.5,
                                height: 300,
                                //  color: _backgroundColor,
                                //movement controll buttons
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //up button//drop down instantly
                                    ControlButton(
                                      onPressed: () {
                                        ref
                                            .read(gameController.notifier)
                                            .dropPiece();
                                        if (vibrate) {
                                          Vibration.vibrate(
                                            duration: 50,
                                            amplitude: 16,
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
                                        //left button
                                        ControlButton(
                                          onPressed: () {
                                            gameState.isPaused ||
                                                    ref.watch(isInitialLaunch)
                                                ? ref
                                                    .read(gradientProvider
                                                        .notifier)
                                                    .toggleBack()
                                                : ref
                                                    .read(
                                                        gameController.notifier)
                                                    .moveLeft();
                                            if (vibrate) {
                                              Vibration.vibrate(
                                                duration: 50,
                                                amplitude: 16,
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
                                        ControlButton(
                                          onPressed: () {
                                            gameState.isPaused ||
                                                    ref.watch(isInitialLaunch)
                                                ? ref
                                                    .read(gradientProvider
                                                        .notifier)
                                                    .toggleBackground()
                                                : ref
                                                    .read(
                                                        gameController.notifier)
                                                    .moveRight();
                                            if (vibrate) {
                                              Vibration.vibrate(
                                                duration: 50,
                                                amplitude: 16,
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
                                    ControlButton(
                                      onPressed: () {
                                        ref
                                            .read(gameController.notifier)
                                            .dropPieceBySteps(2);
                                        if (vibrate) {
                                          Vibration.vibrate(
                                            duration: 50,
                                            amplitude: 16,
                                          );
                                        }
                                      },
                                      buttonSize: ButtonSize().controlButton,
                                      colors: ButtonColors().controlButton,
                                    ),
                                  ],
                                )),
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
                                final initialStart = ref.read(isInitialLaunch);
                                final vibrate = ref.watch(vibrationProvider);

                                return initialStart
                                    ? CustomButton(
                                        onPressed: () {
                                          ref
                                              .read(isInitialLaunch.notifier)
                                              .state = !initialStart;
                                          ref
                                              .read(gameController.notifier)
                                              .startGame();

                                          if (vibrate) {
                                            Vibration.vibrate(
                                              duration: 50,
                                              amplitude: 18,
                                            );
                                          }
                                        },
                                        buttonSize: ButtonSize().mainButton,
                                        colors: ButtonColors().mainButton,
                                        buttonName: 'Start',
                                      )
                                    : gameState.isPaused
                                        ? CustomButton(
                                            onPressed: () {
                                              ref
                                                  .read(pieceColorProvider
                                                      .notifier)
                                                  .toggleColor();
                                              if (vibrate) {
                                                Vibration.vibrate(
                                                  duration: 50,
                                                  amplitude: 18,
                                                );
                                              }
                                            },
                                            buttonSize: ButtonSize().mainButton,
                                            colors: ButtonColors().mainButton,
                                            buttonName: 'Change PieceColor',
                                          )
                                        : CustomButton(
                                            onPressed: () async {
                                              gameState.gameOver || initialStart
                                                  ? ref
                                                      .read(gameController
                                                          .notifier)
                                                      .resetGame()
                                                  : ref
                                                      .read(gameController
                                                          .notifier)
                                                      .rotatePiece();
                                              if (vibrate) {
                                                await Vibration.vibrate(
                                                  duration: 40,
                                                  amplitude: 18,
                                                );
                                              }
                                            },
                                            buttonSize: ButtonSize().mainButton,
                                            colors: ButtonColors().mainButton,
                                            buttonName: gameState.gameOver
                                                ? 'Start'
                                                : 'Rotate',
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
