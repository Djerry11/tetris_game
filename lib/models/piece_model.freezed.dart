// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'piece_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Piece {
  Tetromino get shape => throw _privateConstructorUsedError;
  List<int> get position => throw _privateConstructorUsedError;
  int get rotationState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PieceCopyWith<Piece> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PieceCopyWith<$Res> {
  factory $PieceCopyWith(Piece value, $Res Function(Piece) then) =
      _$PieceCopyWithImpl<$Res, Piece>;
  @useResult
  $Res call({Tetromino shape, List<int> position, int rotationState});
}

/// @nodoc
class _$PieceCopyWithImpl<$Res, $Val extends Piece>
    implements $PieceCopyWith<$Res> {
  _$PieceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shape = null,
    Object? position = null,
    Object? rotationState = null,
  }) {
    return _then(_value.copyWith(
      shape: null == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as Tetromino,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rotationState: null == rotationState
          ? _value.rotationState
          : rotationState // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PieceCopyWith<$Res> implements $PieceCopyWith<$Res> {
  factory _$$_PieceCopyWith(_$_Piece value, $Res Function(_$_Piece) then) =
      __$$_PieceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Tetromino shape, List<int> position, int rotationState});
}

/// @nodoc
class __$$_PieceCopyWithImpl<$Res> extends _$PieceCopyWithImpl<$Res, _$_Piece>
    implements _$$_PieceCopyWith<$Res> {
  __$$_PieceCopyWithImpl(_$_Piece _value, $Res Function(_$_Piece) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shape = null,
    Object? position = null,
    Object? rotationState = null,
  }) {
    return _then(_$_Piece(
      shape: null == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as Tetromino,
      position: null == position
          ? _value._position
          : position // ignore: cast_nullable_to_non_nullable
              as List<int>,
      rotationState: null == rotationState
          ? _value.rotationState
          : rotationState // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Piece implements _Piece {
  const _$_Piece(
      {required this.shape,
      final List<int> position = const [],
      this.rotationState = 1})
      : _position = position;

  @override
  final Tetromino shape;
  final List<int> _position;
  @override
  @JsonKey()
  List<int> get position {
    if (_position is EqualUnmodifiableListView) return _position;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_position);
  }

  @override
  @JsonKey()
  final int rotationState;

  @override
  String toString() {
    return 'Piece(shape: $shape, position: $position, rotationState: $rotationState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Piece &&
            (identical(other.shape, shape) || other.shape == shape) &&
            const DeepCollectionEquality().equals(other._position, _position) &&
            (identical(other.rotationState, rotationState) ||
                other.rotationState == rotationState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shape,
      const DeepCollectionEquality().hash(_position), rotationState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PieceCopyWith<_$_Piece> get copyWith =>
      __$$_PieceCopyWithImpl<_$_Piece>(this, _$identity);
}

abstract class _Piece implements Piece {
  const factory _Piece(
      {required final Tetromino shape,
      final List<int> position,
      final int rotationState}) = _$_Piece;

  @override
  Tetromino get shape;
  @override
  List<int> get position;
  @override
  int get rotationState;
  @override
  @JsonKey(ignore: true)
  _$$_PieceCopyWith<_$_Piece> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GameState {
  Piece get currentPiece => throw _privateConstructorUsedError;
  Piece get nextPiece => throw _privateConstructorUsedError;
  List<List<Tetromino?>> get gameBoard => throw _privateConstructorUsedError;
  int get currentScore => throw _privateConstructorUsedError;
  bool get gameOver => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get vibrate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {Piece currentPiece,
      Piece nextPiece,
      List<List<Tetromino?>> gameBoard,
      int currentScore,
      bool gameOver,
      bool isPaused,
      bool vibrate});

  $PieceCopyWith<$Res> get currentPiece;
  $PieceCopyWith<$Res> get nextPiece;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPiece = null,
    Object? nextPiece = null,
    Object? gameBoard = null,
    Object? currentScore = null,
    Object? gameOver = null,
    Object? isPaused = null,
    Object? vibrate = null,
  }) {
    return _then(_value.copyWith(
      currentPiece: null == currentPiece
          ? _value.currentPiece
          : currentPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
      nextPiece: null == nextPiece
          ? _value.nextPiece
          : nextPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
      gameBoard: null == gameBoard
          ? _value.gameBoard
          : gameBoard // ignore: cast_nullable_to_non_nullable
              as List<List<Tetromino?>>,
      currentScore: null == currentScore
          ? _value.currentScore
          : currentScore // ignore: cast_nullable_to_non_nullable
              as int,
      gameOver: null == gameOver
          ? _value.gameOver
          : gameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrate: null == vibrate
          ? _value.vibrate
          : vibrate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PieceCopyWith<$Res> get currentPiece {
    return $PieceCopyWith<$Res>(_value.currentPiece, (value) {
      return _then(_value.copyWith(currentPiece: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PieceCopyWith<$Res> get nextPiece {
    return $PieceCopyWith<$Res>(_value.nextPiece, (value) {
      return _then(_value.copyWith(nextPiece: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Piece currentPiece,
      Piece nextPiece,
      List<List<Tetromino?>> gameBoard,
      int currentScore,
      bool gameOver,
      bool isPaused,
      bool vibrate});

  @override
  $PieceCopyWith<$Res> get currentPiece;
  @override
  $PieceCopyWith<$Res> get nextPiece;
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$_GameState>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPiece = null,
    Object? nextPiece = null,
    Object? gameBoard = null,
    Object? currentScore = null,
    Object? gameOver = null,
    Object? isPaused = null,
    Object? vibrate = null,
  }) {
    return _then(_$_GameState(
      currentPiece: null == currentPiece
          ? _value.currentPiece
          : currentPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
      nextPiece: null == nextPiece
          ? _value.nextPiece
          : nextPiece // ignore: cast_nullable_to_non_nullable
              as Piece,
      gameBoard: null == gameBoard
          ? _value._gameBoard
          : gameBoard // ignore: cast_nullable_to_non_nullable
              as List<List<Tetromino?>>,
      currentScore: null == currentScore
          ? _value.currentScore
          : currentScore // ignore: cast_nullable_to_non_nullable
              as int,
      gameOver: null == gameOver
          ? _value.gameOver
          : gameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrate: null == vibrate
          ? _value.vibrate
          : vibrate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_GameState implements _GameState {
  const _$_GameState(
      {required this.currentPiece,
      required this.nextPiece,
      required final List<List<Tetromino?>> gameBoard,
      required this.currentScore,
      required this.gameOver,
      required this.isPaused,
      required this.vibrate})
      : _gameBoard = gameBoard;

  @override
  final Piece currentPiece;
  @override
  final Piece nextPiece;
  final List<List<Tetromino?>> _gameBoard;
  @override
  List<List<Tetromino?>> get gameBoard {
    if (_gameBoard is EqualUnmodifiableListView) return _gameBoard;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gameBoard);
  }

  @override
  final int currentScore;
  @override
  final bool gameOver;
  @override
  final bool isPaused;
  @override
  final bool vibrate;

  @override
  String toString() {
    return 'GameState(currentPiece: $currentPiece, nextPiece: $nextPiece, gameBoard: $gameBoard, currentScore: $currentScore, gameOver: $gameOver, isPaused: $isPaused, vibrate: $vibrate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            (identical(other.currentPiece, currentPiece) ||
                other.currentPiece == currentPiece) &&
            (identical(other.nextPiece, nextPiece) ||
                other.nextPiece == nextPiece) &&
            const DeepCollectionEquality()
                .equals(other._gameBoard, _gameBoard) &&
            (identical(other.currentScore, currentScore) ||
                other.currentScore == currentScore) &&
            (identical(other.gameOver, gameOver) ||
                other.gameOver == gameOver) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.vibrate, vibrate) || other.vibrate == vibrate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentPiece,
      nextPiece,
      const DeepCollectionEquality().hash(_gameBoard),
      currentScore,
      gameOver,
      isPaused,
      vibrate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {required final Piece currentPiece,
      required final Piece nextPiece,
      required final List<List<Tetromino?>> gameBoard,
      required final int currentScore,
      required final bool gameOver,
      required final bool isPaused,
      required final bool vibrate}) = _$_GameState;

  @override
  Piece get currentPiece;
  @override
  Piece get nextPiece;
  @override
  List<List<Tetromino?>> get gameBoard;
  @override
  int get currentScore;
  @override
  bool get gameOver;
  @override
  bool get isPaused;
  @override
  bool get vibrate;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
