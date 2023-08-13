import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_game/providers/level_board_provider.dart';

class LevelBoard extends StatelessWidget {
  const LevelBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final level = ref.watch(levelBoardProvider).gameBoard;
          print('UTSAB: $level');
          return TextButton(
              onPressed: () {
                ref.read(levelBoardProvider.notifier).gameLevel(10);
              },
              child: const Text('level'));
        },
      ),
    );
  }
}
