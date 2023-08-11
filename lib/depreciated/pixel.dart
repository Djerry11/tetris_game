// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tetris_game/models/piece_model.dart';
// import 'package:tetris_game/providers/individual_provider.dart';
// import 'package:tetris_game/resources/values.dart';

// // ignore: must_be_immutable
// class Pixel extends StatelessWidget {
//   Pixel({
//     super.key,
//     this.colors,
//     this.isBackground = false,
//   });
//   List<Color>? colors;
//   final bool isBackground;

//   @override
//   Widget build(BuildContext context) {
//     late List<Color> selectedColor;
//     return Consumer(builder: (context, ref, child) {
//       final colorMode = ref.watch(pieceColorProvider);
//       final currentPiece = ref.watch(currentPieceProvider);

//       selectedColor = colors ??
//           (isBackground
//               ? PieceColor().bgPiece
//               : colorMode
//                   ? currentPiece.color
//                   : PieceColor().activePiece);
//       return Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             width: 18,
//             height: 18,
//             decoration: BoxDecoration(
//               color: selectedColor[0],
//               borderRadius: const BorderRadius.all(Radius.circular(2)),
//               border: Border.all(
//                 color: selectedColor[1],
//                 width: 1,
//               ),
//             ),
//           ),
//           Container(
//             width: 11,
//             height: 11,
//             decoration: BoxDecoration(
//               color: selectedColor[1],
//               borderRadius: const BorderRadius.all(Radius.circular(2)),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
