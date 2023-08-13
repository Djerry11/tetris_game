// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameBoardState {
  List<List<Tetromino?>> get gameBoard => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameBoardStateCopyWith<GameBoardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameBoardStateCopyWith<$Res> {
  factory $GameBoardStateCopyWith(
          GameBoardState value, $Res Function(GameBoardState) then) =
      _$GameBoardStateCopyWithImpl<$Res, GameBoardState>;
  @useResult
  $Res call({List<List<Tetromino?>> gameBoard});
}

/// @nodoc
class _$GameBoardStateCopyWithImpl<$Res, $Val extends GameBoardState>
    implements $GameBoardStateCopyWith<$Res> {
  _$GameBoardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameBoard = null,
  }) {
    return _then(_value.copyWith(
      gameBoard: null == gameBoard
          ? _value.gameBoard
          : gameBoard // ignore: cast_nullable_to_non_nullable
              as List<List<Tetromino?>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameBoardStateCopyWith<$Res>
    implements $GameBoardStateCopyWith<$Res> {
  factory _$$_GameBoardStateCopyWith(
          _$_GameBoardState value, $Res Function(_$_GameBoardState) then) =
      __$$_GameBoardStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<List<Tetromino?>> gameBoard});
}

/// @nodoc
class __$$_GameBoardStateCopyWithImpl<$Res>
    extends _$GameBoardStateCopyWithImpl<$Res, _$_GameBoardState>
    implements _$$_GameBoardStateCopyWith<$Res> {
  __$$_GameBoardStateCopyWithImpl(
      _$_GameBoardState _value, $Res Function(_$_GameBoardState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameBoard = null,
  }) {
    return _then(_$_GameBoardState(
      gameBoard: null == gameBoard
          ? _value._gameBoard
          : gameBoard // ignore: cast_nullable_to_non_nullable
              as List<List<Tetromino?>>,
    ));
  }
}

/// @nodoc

class _$_GameBoardState implements _GameBoardState {
  const _$_GameBoardState({required final List<List<Tetromino?>> gameBoard})
      : _gameBoard = gameBoard;

  final List<List<Tetromino?>> _gameBoard;
  @override
  List<List<Tetromino?>> get gameBoard {
    if (_gameBoard is EqualUnmodifiableListView) return _gameBoard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gameBoard);
  }

  @override
  String toString() {
    return 'GameBoardState(gameBoard: $gameBoard)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameBoardState &&
            const DeepCollectionEquality()
                .equals(other._gameBoard, _gameBoard));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_gameBoard));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameBoardStateCopyWith<_$_GameBoardState> get copyWith =>
      __$$_GameBoardStateCopyWithImpl<_$_GameBoardState>(this, _$identity);
}

abstract class _GameBoardState implements GameBoardState {
  const factory _GameBoardState(
      {required final List<List<Tetromino?>> gameBoard}) = _$_GameBoardState;

  @override
  List<List<Tetromino?>> get gameBoard;
  @override
  @JsonKey(ignore: true)
  _$$_GameBoardStateCopyWith<_$_GameBoardState> get copyWith =>
      throw _privateConstructorUsedError;
}
