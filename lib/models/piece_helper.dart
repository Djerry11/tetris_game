// import 'package:flutter/material.dart';

// import '../home_screen.dart';
// import '../resources/values.dart';
// import 'piece_model.dart';

// class PieceHelper {
//   static List<Color> getColor(Piece piece) {
//     return tetrominoColor[piece.shape] ??
//         [const Color.fromARGB(255, 164, 148, 148), Colors.black];
//   }

//   static Piece initializePiece(Tetromino shape) {
//     List<int> position = [];

//     switch (shape) {
//       case Tetromino.I:
//         position.addAll([-7, -6, -5, -4]);
//         break;
//       case Tetromino.O:
//         position.addAll([-16, -15, -6, -5]);
//         break;
//       case Tetromino.T:
//         position.addAll([-16, -15, -14, -5]);
//         break;
//       case Tetromino.S:
//         position.addAll([-14, -15, -5, -6]);
//         break;
//       case Tetromino.Z:
//         position.addAll([-16, -15, -5, -4]);
//         break;
//       case Tetromino.J:
//         position.addAll([-17, -16, -15, -5]);
//         break;
//       case Tetromino.L:
//         position.addAll([-14, -15, -16, -6]);
//         break;
//       default:
//         break;
//     }

//     return Piece(
//       shape: shape,
//       position: position,
//     );
//   }

//   static Piece initializeNextPiece(Tetromino shape) {
//     //determine the shape of tetromino in gridboard
//     List<int> position = [];

//     switch (shape) {
//       case Tetromino.I:
//         position.addAll([0, 1, 2, 3]);
//         break;
//       case Tetromino.O:
//         position.addAll([1, 2, 5, 6]);
//         break;
//       case Tetromino.T:
//         position = [1, 2, 3, 6];

//         break;
//       case Tetromino.S:
//         position.addAll([1, 2, 4, 5]);

//         break;
//       case Tetromino.Z:
//         position.addAll([1, 2, 6, 7]);

//         break;
//       case Tetromino.J:
//         position.addAll([0, 1, 2, 6]);

//         break;
//       case Tetromino.L:
//         position.addAll([1, 2, 3, 5]);

//         break;
//       default:
//     }
//     return Piece(shape: shape, position: position);
//   }

//   static Piece rotatePiece(Piece piece) {
//     var rotationState = piece.rotationState;
//     List<int> position = List.from(piece.position);
//     List<int> newPosition = [];
//     //rotatre the tetromino
//     switch (piece.shape) {
//       case Tetromino.L:
//         switch (rotationState) {
//           case 3:
//             /*
//             o
//             o
//             o o
//           */
//             newPosition = [
//               position[1] - maxCol,
//               position[1],
//               position[1] + maxCol,
//               position[1] + maxCol + 1,
//             ];
//             //check if the new postion is valid and update accordingly
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 0:
//             /*
//               o o o
//               o
//           */
//             newPosition = [
//               position[1] + 1,
//               position[1],
//               position[1] - 1,
//               position[1] + maxCol - 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 1:
//             /*
//            o o
//              o
//              o
//           */
//             newPosition = [
//               position[1] + maxCol,
//               position[1],
//               position[1] - maxCol,
//               position[1] - maxCol - 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 2:
//             /*
//                 o
//             o o o 
//           */
//             newPosition = [
//               position[1] - 1,
//               position[1],
//               position[1] + 1,
//               position[1] - maxCol + 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//         }
//         break;
//       case Tetromino.J:
//         switch (rotationState) {
//           case 1:
//             /*
//             o
//             o
//           o o 
//           */
//             newPosition = [
//               position[1] - maxCol,
//               position[1],
//               position[1] + maxCol,
//               position[1] + maxCol - 1,
//             ];
//             //check if the new postion is valid and update accordingly
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 2:
//             /*
//               o
//               o o o
              
//           */
//             newPosition = [
//               position[1] + 1,
//               position[1],
//               position[1] - 1,
//               position[1] - maxCol - 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 3:
//             /*
//              o o
//              o
//              o
//           */
//             newPosition = [
//               position[1] + maxCol,
//               position[1],
//               position[1] - maxCol,
//               position[1] - maxCol + 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 0:
//             /*
//             o o o 
//                 o
//           */
//             newPosition = [
//               position[1] - 1,
//               position[1],
//               position[1] + 1,
//               position[1] + maxCol + 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//         }
//         break;
//       case Tetromino.T:
//         switch (rotationState) {
//           case 0:
//             /*
//           o o o
//             o
            
//           */
//             newPosition = [
//               position[1] - 1,
//               position[1],
//               position[1] + 1,
//               position[1] + maxCol,
//             ];
//             //check if the new postion is valid and update accordingly
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 1:
//             /*
//               o
//             o o
//               o
//           */
//             newPosition = [
//               position[1] - maxCol,
//               position[1],
//               position[1] + maxCol,
//               position[1] - 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 2:
//             /*
//              o
//            o o o
//           */
//             newPosition = [
//               position[1] + 1,
//               position[1],
//               position[1] - 1,
//               position[1] - maxCol,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 3:
//             /*
//                 o
//                 o o
//                 o 
//           */
//             newPosition = [
//               position[1] + maxCol,
//               position[1],
//               position[1] - maxCol,
//               position[1] + 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 4;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//         }
//         break;
//       case Tetromino.Z:
//         switch (rotationState) {
//           case 0:
//             /*
//           o o
//             o o
//           */
//             newPosition = [
//               position[1] - 1,
//               position[1],
//               position[1] + maxCol,
//               position[1] + maxCol + 1,
//             ];
//             //check if the new postion is valid and update accordingly
//             if (isPiecePosValid(newPosition)) {
//               piece = piece.copyWith(position: newPosition);
//               rotationState = (rotationState + 1) % 2;
//             }
//             break;
//           case 1:
//             /*
//                 o
//               o o
//               o
//           */
//             newPosition = [
//               position[1] - maxCol,
//               position[1],
//               position[1] - 1,
//               position[1] + maxCol - 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               piece = piece.copyWith(position: newPosition);
//               rotationState = (rotationState + 1) % 2;
//             }
//             break;
//         }
//         break;
//       case Tetromino.S:
//         switch (rotationState) {
//           case 0:
//             /*
//               o o
//             o o
//           */
//             newPosition = [
//               position[1] + 1,
//               position[1],
//               position[1] + maxCol,
//               position[1] + maxCol - 1,
//             ];
//             //check if the new postion is valid and update accordingly
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 2;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 1:
//             /*
//               o
//               o o
//                 o
//           */
//             newPosition = [
//               position[1] - maxCol,
//               position[1],
//               position[1] + 1,
//               position[1] + maxCol + 1,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 2;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//         }
//         break;
//       case Tetromino.O:
//         switch (rotationState) {
//           /*
//           o o
//           o o
//           */
//         }
//       case Tetromino.I:
//         switch (rotationState) {
//           case 0:
//             /*
//             o o o o
            
//           */
//             newPosition = [
//               position[1] - 1,
//               position[1],
//               position[1] + 1,
//               position[1] + 2,
//             ];
//             //check if the new postion is valid and update accordingly
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 2;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//           case 1:
//             /*
//               o
//               o
//               o
//               o
              
//           */
//             newPosition = [
//               position[1] - maxCol,
//               position[1],
//               position[1] + maxCol,
//               position[1] + 2 * maxCol,
//             ];
//             if (isPiecePosValid(newPosition)) {
//               rotationState = (rotationState + 1) % 2;
//               piece = piece.copyWith(
//                   position: newPosition, rotationState: rotationState);
//             }
//             break;
//         }
//         break;

//       default:
//     }
//     return piece;
//   }

//   static bool isPosValid(int position) {
//     //get the row and column according to the position of piece
//     int row = (position / maxCol).floor();
//     int col = position % maxCol;
//     //return false if the position is occupied in the board
//     if (row < 0 || gameBoard[row][col] != null || col < 0) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   static bool isPiecePosValid(List<int> piecePos) {
//     bool isInFirstCol = false;
//     bool isInLastCol = false;
//     //check for each position of piece
//     for (int pos in piecePos) {
//       //return false if any one of the position is invalid
//       if (!isPosValid(pos)) {
//         return false;
//       }
//       //check if the piece is in first column
//       if (pos % maxCol == 0) {
//         isInFirstCol = true;
//       }
//       //check if the piece is in last column
//       if (pos % maxCol == maxCol - 1) {
//         isInLastCol = true;
//       }
//     }
//     //return false if the piece is in first and last column
//     if (isInFirstCol && isInLastCol) {
//       return false;
//     } else {
//       return true;
//     }
//   }

//   static Piece movePiece(Piece piece, Direction direction) {
//     List<int> newPosition = List.from(piece.position);
//     switch (direction) {
//       case Direction.left:
//         for (int i = 0; i < piece.position.length; i++) {
//           newPosition[i]--;
//         }
//         break;

//       case Direction.right:
//         for (int i = 0; i < piece.position.length; i++) {
//           newPosition[i]++;
//         }
//         break;

//       case Direction.down:
//         for (int i = 0; i < piece.position.length; i++) {
//           newPosition[i] += maxCol;
//         }
//         break;
//     }
//     return piece.copyWith(position: newPosition);
//   }
// }
