import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "GAME OVER";
    String subtitle = 'PRESS START \nTO \nPLAY';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.pressStart2p(
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.pressStart2p(
            textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
