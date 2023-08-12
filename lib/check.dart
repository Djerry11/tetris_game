import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CheckAudio extends StatefulWidget {
  const CheckAudio({super.key});

  @override
  State<CheckAudio> createState() => _CheckAudioState();
}

class _CheckAudioState extends State<CheckAudio> {
  final player1 = AudioPlayer();
  final player2 = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await player1.play(
                  AssetSource('initialsetup.mp3'),
                );
              },
              child: const Icon(Icons.play_arrow),
            ),
            ElevatedButton(
              onPressed: () async {
                await player1.stop();
              },
              child: const Icon(Icons.stop_circle),
            ),
            ElevatedButton(
              onPressed: () async {
                await player1.play(
                  AssetSource('move.mp3'),
                );
              },
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
