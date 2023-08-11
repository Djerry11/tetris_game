// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tetris_game/providers/tetris_state.dart';
// import 'package:tetris_game/resources/values.dart';

// var i = 0;

// class GameSettingNotifier extends StateNotifier<GameSettingState> {
//   GameSettingNotifier()
//       : super(GameSettingState(
//           isVibrate: true,
//           isPaused: false,
//           isColor: true,
//           screenColor: colorGradients[i],
//         ));

//   void toggleVibration() {
//     state = state.copyWith(isVibrate: !state.isVibrate);
//     //state = GameSettingState(isVibrate: !state.isVibrate);
//   }

//   void togglePause() {
//     state = state.copyWith(isPaused: !state.isPaused);
//     //state = GameSettingState(isPaused: !state.isPaused);
//   }

//   void toggleColor() {
//     state = state.copyWith(isColor: !state.isColor);
//     // state = GameSettingState(isColor: !state.isColor);
//   }

//   void toggleBackground() {
//     state = state.copyWith(
//         screenColor: colorGradients[++i % colorGradients.length]);
//   }
// }

// final gameSettingProvider =
//     StateNotifierProvider<GameSettingNotifier, GameSettingState>((ref) {
//   return GameSettingNotifier();
// });


// // import 'dart:async';
// // import 'dart:math';

// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:tetris_game/providers/tetris_state.dart';
// // import 'package:tetris_game/tetromino_pieces.dart';

// // import '../values.dart';

// // List<List<Tetromino?>> gameBoard = List.generate(
// //   maxRow,
// //   (row) => List.generate(maxCol, (col) => null),
// // );

// // Piece nextPiece =
// //     Piece(shape: Tetromino.values[Random().nextInt(Tetromino.values.length)]);
// // Timer? gameLoopTimer;

// // class TetrisNotifier extends StateNotifier<dynamic> {
// //   TetrisNotifier()
// //       : super(TetrisState(
// //           score: 0,
// //           isPaused: false,
// //           piecePosition: nextPiece.position,
// //           gameOver: false,
// //           pieceShape: nextPiece.shape,
// //         ));
// //   // Initialize your game state variables here
// //   // state.score = 1000;

// //   //create piece and loop the game
// //   void startGame() {
// //     // Identify the shape of the current piece
// //     Piece currentPiece = nextPiece;
// //     // Cancel the previous timer if it exists
// //     currentPiece.initializePiece();

// //     gameLoopTimer?.cancel();

// //     // Screen refresh time
// //     Duration frameRefreshRate = const Duration(milliseconds: 800);

// //     // Start the new game loop timer
// //     gameLoopTimer = loopGame(frameRefreshRate);
// //   }

// //   Timer loopGame(Duration frameRefreshRate) {
// //     return Timer.periodic(
// //       frameRefreshRate,
// //       (timer) {
// //         if (!state.isPaused) {
// //           //  clearLine();
// //           //  checkLanding();
// //           //   if (gameOver) {
// //           //     timer.cancel();
// //           //     showGameOverMessage(context);
// //           state = state.copyWith(
// //             piecePosition: nextPiece.position,
// //             pieceShape: nextPiece.shape,
// //           );
// //         }
// //       },
// //     );
// //   }

// //   // Your game-related logic and state management methods here
// //   // Define methods to move pieces, rotate, reset game, etc.
// // }

// // final tetrisProvider = StateNotifierProvider<TetrisNotifier, dynamic>((ref) {
// //   return TetrisNotifier();
// // });
