// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tetris_game/pixel.dart';
// import 'package:tetris_game/providers/game_state_provider.dart';
// import 'package:tetris_game/resources/button_colors.dart';
// import 'package:tetris_game/resources/values.dart';

// class CheckScreen extends StatefulWidget {
//   const CheckScreen({super.key});

//   @override
//   State<CheckScreen> createState() => _CheckScreenState();
// }

// class _CheckScreenState extends State<CheckScreen> {
//   // var piece = PieceHelper.initializePiece(Tetromino.L);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer(builder: (context, ref, child) {
//         final gameState = ref.watch(gameController);
//         return Column(
//           children: [
//             Container(
//               color: Colors.white54,
//               width: 200,
//               height: 500,
//               child: GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: maxCol,
//                 ),
//                 itemCount: maxRow * maxCol,
//                 itemBuilder: (context, index) {
//                   final row = (index / maxCol).floor();
//                   final col = index % maxCol;
//                   //display shape of current piece in board
//                   if (gameState.currentPiece.position.contains(index)) {
//                     return Pixel(colors: PieceColor().activePiece);
//                   } else if (gameState.gameBoard[row][col] != null) {
//                     return Pixel(colors: PieceColor().activePiece);
//                   } else {
//                     return Pixel(colors: PieceColor().bgPiece);
//                   }
//                 },
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 ref.read(gameController.notifier).rotatePiece();
//               },
//               child: const Text('Press'),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
