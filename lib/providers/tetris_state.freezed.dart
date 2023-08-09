// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tetris_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameSettingState {
  bool get isVibrate => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get isColor => throw _privateConstructorUsedError;
  List<Color> get screenColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameSettingStateCopyWith<GameSettingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSettingStateCopyWith<$Res> {
  factory $GameSettingStateCopyWith(
          GameSettingState value, $Res Function(GameSettingState) then) =
      _$GameSettingStateCopyWithImpl<$Res, GameSettingState>;
  @useResult
  $Res call(
      {bool isVibrate, bool isPaused, bool isColor, List<Color> screenColor});
}

/// @nodoc
class _$GameSettingStateCopyWithImpl<$Res, $Val extends GameSettingState>
    implements $GameSettingStateCopyWith<$Res> {
  _$GameSettingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isVibrate = null,
    Object? isPaused = null,
    Object? isColor = null,
    Object? screenColor = null,
  }) {
    return _then(_value.copyWith(
      isVibrate: null == isVibrate
          ? _value.isVibrate
          : isVibrate // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isColor: null == isColor
          ? _value.isColor
          : isColor // ignore: cast_nullable_to_non_nullable
              as bool,
      screenColor: null == screenColor
          ? _value.screenColor
          : screenColor // ignore: cast_nullable_to_non_nullable
              as List<Color>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameSettingStateCopyWith<$Res>
    implements $GameSettingStateCopyWith<$Res> {
  factory _$$_GameSettingStateCopyWith(
          _$_GameSettingState value, $Res Function(_$_GameSettingState) then) =
      __$$_GameSettingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isVibrate, bool isPaused, bool isColor, List<Color> screenColor});
}

/// @nodoc
class __$$_GameSettingStateCopyWithImpl<$Res>
    extends _$GameSettingStateCopyWithImpl<$Res, _$_GameSettingState>
    implements _$$_GameSettingStateCopyWith<$Res> {
  __$$_GameSettingStateCopyWithImpl(
      _$_GameSettingState _value, $Res Function(_$_GameSettingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isVibrate = null,
    Object? isPaused = null,
    Object? isColor = null,
    Object? screenColor = null,
  }) {
    return _then(_$_GameSettingState(
      isVibrate: null == isVibrate
          ? _value.isVibrate
          : isVibrate // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isColor: null == isColor
          ? _value.isColor
          : isColor // ignore: cast_nullable_to_non_nullable
              as bool,
      screenColor: null == screenColor
          ? _value._screenColor
          : screenColor // ignore: cast_nullable_to_non_nullable
              as List<Color>,
    ));
  }
}

/// @nodoc

class _$_GameSettingState implements _GameSettingState {
  const _$_GameSettingState(
      {this.isVibrate = true,
      this.isPaused = false,
      this.isColor = true,
      required final List<Color> screenColor})
      : _screenColor = screenColor;

  @override
  @JsonKey()
  final bool isVibrate;
  @override
  @JsonKey()
  final bool isPaused;
  @override
  @JsonKey()
  final bool isColor;
  final List<Color> _screenColor;
  @override
  List<Color> get screenColor {
    if (_screenColor is EqualUnmodifiableListView) return _screenColor;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screenColor);
  }

  @override
  String toString() {
    return 'GameSettingState(isVibrate: $isVibrate, isPaused: $isPaused, isColor: $isColor, screenColor: $screenColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameSettingState &&
            (identical(other.isVibrate, isVibrate) ||
                other.isVibrate == isVibrate) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.isColor, isColor) || other.isColor == isColor) &&
            const DeepCollectionEquality()
                .equals(other._screenColor, _screenColor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isVibrate, isPaused, isColor,
      const DeepCollectionEquality().hash(_screenColor));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameSettingStateCopyWith<_$_GameSettingState> get copyWith =>
      __$$_GameSettingStateCopyWithImpl<_$_GameSettingState>(this, _$identity);
}

abstract class _GameSettingState implements GameSettingState {
  const factory _GameSettingState(
      {final bool isVibrate,
      final bool isPaused,
      final bool isColor,
      required final List<Color> screenColor}) = _$_GameSettingState;

  @override
  bool get isVibrate;
  @override
  bool get isPaused;
  @override
  bool get isColor;
  @override
  List<Color> get screenColor;
  @override
  @JsonKey(ignore: true)
  _$$_GameSettingStateCopyWith<_$_GameSettingState> get copyWith =>
      throw _privateConstructorUsedError;
}
