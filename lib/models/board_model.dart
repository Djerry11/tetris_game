import 'package:freezed_annotation/freezed_annotation.dart';

import '../resources/values.dart';
part 'board_model.freezed.dart';

@freezed
class GameBoardState with _$GameBoardState {
  const factory GameBoardState({
    required List<List<Tetromino?>> gameBoard,
  }) = _GameBoardState;
}
