import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:tetris_game/values.dart';

part 'tetris_state.freezed.dart';

@freezed
class GameSettingState with _$GameSettingState {
  const factory GameSettingState({
    @Default(true) bool isVibrate,
    @Default(false) bool isPaused,
    @Default(true) bool isColor,
  }) = _GameSettingState;
}






// @unfreezed
// class TetrisState with _$TetrisState {
//   const factory TetrisState({
//     // Define your game state variables here
//     @Default(0) int score,
//     @Default(false) bool isPaused,
//     required List<int> piecePosition,
//     @Default(false) bool gameOver,
//     required Tetromino pieceShape,
//   }) = _TetrisState;
// }
