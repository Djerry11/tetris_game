// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

// part of 'tetris_state.dart';

// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************

// T _$identity<T>(T value) => value;

// final _privateConstructorUsedError = UnsupportedError(
//     'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

// /// @nodoc
// mixin _$TetrisState {
// // Define your game state variables here
//   int get score =>
//       throw _privateConstructorUsedError; // Define your game state variables here
//   set score(int value) => throw _privateConstructorUsedError;
//   bool get isPaused => throw _privateConstructorUsedError;
//   set isPaused(bool value) => throw _privateConstructorUsedError;
//   List<int> get piecePosition => throw _privateConstructorUsedError;
//   set piecePosition(List<int> value) => throw _privateConstructorUsedError;
//   bool get gameOver => throw _privateConstructorUsedError;
//   set gameOver(bool value) => throw _privateConstructorUsedError;
//   Tetromino get pieceShape => throw _privateConstructorUsedError;
//   set pieceShape(Tetromino value) => throw _privateConstructorUsedError;

//   @JsonKey(ignore: true)
//   $TetrisStateCopyWith<TetrisState> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class $TetrisStateCopyWith<$Res> {
//   factory $TetrisStateCopyWith(
//           TetrisState value, $Res Function(TetrisState) then) =
//       _$TetrisStateCopyWithImpl<$Res, TetrisState>;
//   @useResult
//   $Res call(
//       {int score,
//       bool isPaused,
//       List<int> piecePosition,
//       bool gameOver,
//       Tetromino pieceShape});
// }

// /// @nodoc
// class _$TetrisStateCopyWithImpl<$Res, $Val extends TetrisState>
//     implements $TetrisStateCopyWith<$Res> {
//   _$TetrisStateCopyWithImpl(this._value, this._then);

//   // ignore: unused_field
//   final $Val _value;
//   // ignore: unused_field
//   final $Res Function($Val) _then;

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? score = null,
//     Object? isPaused = null,
//     Object? piecePosition = null,
//     Object? gameOver = null,
//     Object? pieceShape = null,
//   }) {
//     return _then(_value.copyWith(
//       score: null == score
//           ? _value.score
//           : score // ignore: cast_nullable_to_non_nullable
//               as int,
//       isPaused: null == isPaused
//           ? _value.isPaused
//           : isPaused // ignore: cast_nullable_to_non_nullable
//               as bool,
//       piecePosition: null == piecePosition
//           ? _value.piecePosition
//           : piecePosition // ignore: cast_nullable_to_non_nullable
//               as List<int>,
//       gameOver: null == gameOver
//           ? _value.gameOver
//           : gameOver // ignore: cast_nullable_to_non_nullable
//               as bool,
//       pieceShape: null == pieceShape
//           ? _value.pieceShape
//           : pieceShape // ignore: cast_nullable_to_non_nullable
//               as Tetromino,
//     ) as $Val);
//   }
// }

// /// @nodoc
// abstract class _$$_TetrisStateCopyWith<$Res>
//     implements $TetrisStateCopyWith<$Res> {
//   factory _$$_TetrisStateCopyWith(
//           _$_TetrisState value, $Res Function(_$_TetrisState) then) =
//       __$$_TetrisStateCopyWithImpl<$Res>;
//   @override
//   @useResult
//   $Res call(
//       {int score,
//       bool isPaused,
//       List<int> piecePosition,
//       bool gameOver,
//       Tetromino pieceShape});
// }

// /// @nodoc
// class __$$_TetrisStateCopyWithImpl<$Res>
//     extends _$TetrisStateCopyWithImpl<$Res, _$_TetrisState>
//     implements _$$_TetrisStateCopyWith<$Res> {
//   __$$_TetrisStateCopyWithImpl(
//       _$_TetrisState _value, $Res Function(_$_TetrisState) _then)
//       : super(_value, _then);

//   @pragma('vm:prefer-inline')
//   @override
//   $Res call({
//     Object? score = null,
//     Object? isPaused = null,
//     Object? piecePosition = null,
//     Object? gameOver = null,
//     Object? pieceShape = null,
//   }) {
//     return _then(_$_TetrisState(
//       score: null == score
//           ? _value.score
//           : score // ignore: cast_nullable_to_non_nullable
//               as int,
//       isPaused: null == isPaused
//           ? _value.isPaused
//           : isPaused // ignore: cast_nullable_to_non_nullable
//               as bool,
//       piecePosition: null == piecePosition
//           ? _value.piecePosition
//           : piecePosition // ignore: cast_nullable_to_non_nullable
//               as List<int>,
//       gameOver: null == gameOver
//           ? _value.gameOver
//           : gameOver // ignore: cast_nullable_to_non_nullable
//               as bool,
//       pieceShape: null == pieceShape
//           ? _value.pieceShape
//           : pieceShape // ignore: cast_nullable_to_non_nullable
//               as Tetromino,
//     ));
//   }
// }

// /// @nodoc

// class _$_TetrisState implements _TetrisState {
//   const _$_TetrisState(
//       {this.score = 0,
//       this.isPaused = false,
//       required this.piecePosition,
//       this.gameOver = false,
//       required this.pieceShape});

// // Define your game state variables here
//   @override
//   @JsonKey()
//   int score;
//   @override
//   @JsonKey()
//   bool isPaused;
//   @override
//   List<int> piecePosition;
//   @override
//   @JsonKey()
//   bool gameOver;
//   @override
//   Tetromino pieceShape;

//   @override
//   String toString() {
//     return 'TetrisState(score: $score, isPaused: $isPaused, piecePosition: $piecePosition, gameOver: $gameOver, pieceShape: $pieceShape)';
//   }

//   @JsonKey(ignore: true)
//   @override
//   @pragma('vm:prefer-inline')
//   _$$_TetrisStateCopyWith<_$_TetrisState> get copyWith =>
//       __$$_TetrisStateCopyWithImpl<_$_TetrisState>(this, _$identity);
// }

// abstract class _TetrisState implements TetrisState {
//   const factory _TetrisState(
//       {int score,
//       bool isPaused,
//       required List<int> piecePosition,
//       bool gameOver,
//       required Tetromino pieceShape}) = _$_TetrisState;

//   @override // Define your game state variables here
//   int get score; // Define your game state variables here
//   set score(int value);
//   @override
//   bool get isPaused;
//   set isPaused(bool value);
//   @override
//   List<int> get piecePosition;
//   set piecePosition(List<int> value);
//   @override
//   bool get gameOver;
//   set gameOver(bool value);
//   @override
//   Tetromino get pieceShape;
//   set pieceShape(Tetromino value);
//   @override
//   @JsonKey(ignore: true)
//   _$$_TetrisStateCopyWith<_$_TetrisState> get copyWith =>
//       throw _privateConstructorUsedError;
// }
