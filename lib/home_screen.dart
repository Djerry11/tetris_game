import 'package:flutter/material.dart';
import 'package:tetris_game/buttons/cutom_button.dart';
import 'package:tetris_game/resources/button_colors.dart';
import 'package:tetris_game/resources/button_size.dart';
import 'package:tetris_game/tetris_board.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.blueGrey.shade600;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //Display Screen for the game
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 40,
              ),

              //Display Screen for the game TetrisBoard ,scores,level,lines,next piece
              child: Container(
                height: height * 0.478,
                width: width * 0.7,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 2,
                  ),
                  color: Colors.green.shade50,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.51,
                      width: width * 0.46,
                      child: const TetrisBoard(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //Setting/options buttons list tiny buttons
            ClipRRect(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                child: ClipRect(
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.4,
                      ),
                      //list of options tiny buttons
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //Reset Button
                          CustomButton(
                            onPressed: () async {
                              Vibration.vibrate(duration: 50, amplitude: 24);
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().resetButton,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //Pause Button/playbutton
                          CustomButton(
                            onPressed: () async {
                              Vibration.vibrate(duration: 50, amplitude: 24);
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().tinyButton,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //Sound Button
                          CustomButton(
                            onPressed: () async {
                              Vibration.vibrate(duration: 50, amplitude: 24);
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().tinyButton,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //Options Button
                          CustomButton(
                            onPressed: () async {
                              Vibration.vibrate(duration: 50, amplitude: 24);
                            },
                            buttonSize: ButtonSize().tinyButton,
                            colors: ButtonColors().tinyButton,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Game control buttons
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 30, 25),
                    child: SizedBox(
                        width: width * 0.5,
                        height: double.infinity,
                        //  color: _backgroundColor,
                        //movement controll buttons
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //up button
                            CustomButton(
                              onPressed: () {
                                Vibration.vibrate(
                                  duration: 50,
                                  amplitude: 28,
                                );
                              },
                              buttonSize: ButtonSize().controlButton,
                              colors: ButtonColors().controlButton,
                            ),
                            //left and right buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //left button
                                CustomButton(
                                  onPressed: () {
                                    Vibration.vibrate(
                                      duration: 50,
                                      amplitude: 28,
                                    );
                                  },
                                  buttonSize: ButtonSize().controlButton,
                                  colors: ButtonColors().controlButton,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                //right button
                                CustomButton(
                                  onPressed: () {
                                    Vibration.vibrate(
                                      duration: 50,
                                      amplitude: 28,
                                    );
                                  },
                                  buttonSize: ButtonSize().controlButton,
                                  colors: ButtonColors().controlButton,
                                ),
                              ],
                            ),
                            //down button
                            CustomButton(
                              onPressed: () {
                                Vibration.vibrate(
                                  duration: 50,
                                  amplitude: 20,
                                );
                              },
                              buttonSize: ButtonSize().controlButton,
                              colors: ButtonColors().controlButton,
                            ),
                          ],
                        )),
                  ),
                  //main button /Rotate button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 40),
                    child: SizedBox(
                      width: width * 0.35,
                      height: double.infinity,
                      //  color: _backgroundColor,
                      child: Center(
                          //Rotate Buttonf
                          child: CustomButton(
                        onPressed: () {
                          Vibration.vibrate(
                            duration: 50,
                            amplitude: 22,
                          );
                        },
                        buttonSize: ButtonSize().mainButton,
                        colors: ButtonColors().mainButton,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
