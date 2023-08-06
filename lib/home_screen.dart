import 'package:flutter/material.dart';
import 'package:tetris_game/buttons/cutom_button.dart';
import 'package:tetris_game/resources/button_colors.dart';
import 'package:tetris_game/resources/button_size.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.maxFinite,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Container(
                      height: 450,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                child: ClipRect(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {
                          Vibration.vibrate(
                            duration: 600,
                            amplitude: 300,
                          );
                        },
                        buttonSize: ButtonSize().controlButton,
                        colors: ButtonColors().mainButton,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
