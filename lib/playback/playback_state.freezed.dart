// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaybackState {
  PlaybackStatus get status;
  double get speed;
  Duration get progress;
  PracticeMode get practiceMode;
  HandIsolation get handIsolation;
  bool get isLooping;
  Duration? get loopStart;
  Duration? get loopEnd;
  Set<int> get waitingForNotes;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlaybackStateCopyWith<PlaybackState> get copyWith =>
      _$PlaybackStateCopyWithImpl<PlaybackState>(
          this as PlaybackState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlaybackState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.practiceMode, practiceMode) ||
                other.practiceMode == practiceMode) &&
            (identical(other.handIsolation, handIsolation) ||
                other.handIsolation == handIsolation) &&
            (identical(other.isLooping, isLooping) ||
                other.isLooping == isLooping) &&
            (identical(other.loopStart, loopStart) ||
                other.loopStart == loopStart) &&
            (identical(other.loopEnd, loopEnd) || other.loopEnd == loopEnd) &&
            const DeepCollectionEquality()
                .equals(other.waitingForNotes, waitingForNotes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      speed,
      progress,
      practiceMode,
      handIsolation,
      isLooping,
      loopStart,
      loopEnd,
      const DeepCollectionEquality().hash(waitingForNotes));

  @override
  String toString() {
    return 'PlaybackState(status: $status, speed: $speed, progress: $progress, practiceMode: $practiceMode, handIsolation: $handIsolation, isLooping: $isLooping, loopStart: $loopStart, loopEnd: $loopEnd, waitingForNotes: $waitingForNotes)';
  }
}

/// @nodoc
abstract mixin class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) _then) =
      _$PlaybackStateCopyWithImpl;
  @useResult
  $Res call(
      {PlaybackStatus status,
      double speed,
      Duration progress,
      PracticeMode practiceMode,
      HandIsolation handIsolation,
      bool isLooping,
      Duration? loopStart,
      Duration? loopEnd,
      Set<int> waitingForNotes});
}

/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._self, this._then);

  final PlaybackState _self;
  final $Res Function(PlaybackState) _then;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? speed = null,
    Object? progress = null,
    Object? practiceMode = null,
    Object? handIsolation = null,
    Object? isLooping = null,
    Object? loopStart = freezed,
    Object? loopEnd = freezed,
    Object? waitingForNotes = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlaybackStatus,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Duration,
      practiceMode: null == practiceMode
          ? _self.practiceMode
          : practiceMode // ignore: cast_nullable_to_non_nullable
              as PracticeMode,
      handIsolation: null == handIsolation
          ? _self.handIsolation
          : handIsolation // ignore: cast_nullable_to_non_nullable
              as HandIsolation,
      isLooping: null == isLooping
          ? _self.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      loopStart: freezed == loopStart
          ? _self.loopStart
          : loopStart // ignore: cast_nullable_to_non_nullable
              as Duration?,
      loopEnd: freezed == loopEnd
          ? _self.loopEnd
          : loopEnd // ignore: cast_nullable_to_non_nullable
              as Duration?,
      waitingForNotes: null == waitingForNotes
          ? _self.waitingForNotes
          : waitingForNotes // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlaybackState].
extension PlaybackStatePatterns on PlaybackState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PlaybackState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PlaybackState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PlaybackState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            PlaybackStatus status,
            double speed,
            Duration progress,
            PracticeMode practiceMode,
            HandIsolation handIsolation,
            bool isLooping,
            Duration? loopStart,
            Duration? loopEnd,
            Set<int> waitingForNotes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(
            _that.status,
            _that.speed,
            _that.progress,
            _that.practiceMode,
            _that.handIsolation,
            _that.isLooping,
            _that.loopStart,
            _that.loopEnd,
            _that.waitingForNotes);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            PlaybackStatus status,
            double speed,
            Duration progress,
            PracticeMode practiceMode,
            HandIsolation handIsolation,
            bool isLooping,
            Duration? loopStart,
            Duration? loopEnd,
            Set<int> waitingForNotes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState():
        return $default(
            _that.status,
            _that.speed,
            _that.progress,
            _that.practiceMode,
            _that.handIsolation,
            _that.isLooping,
            _that.loopStart,
            _that.loopEnd,
            _that.waitingForNotes);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            PlaybackStatus status,
            double speed,
            Duration progress,
            PracticeMode practiceMode,
            HandIsolation handIsolation,
            bool isLooping,
            Duration? loopStart,
            Duration? loopEnd,
            Set<int> waitingForNotes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaybackState() when $default != null:
        return $default(
            _that.status,
            _that.speed,
            _that.progress,
            _that.practiceMode,
            _that.handIsolation,
            _that.isLooping,
            _that.loopStart,
            _that.loopEnd,
            _that.waitingForNotes);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PlaybackState extends PlaybackState {
  const _PlaybackState(
      {this.status = PlaybackStatus.stopped,
      this.speed = 1.0,
      this.progress = Duration.zero,
      this.practiceMode = PracticeMode.normal,
      this.handIsolation = HandIsolation.both,
      this.isLooping = false,
      this.loopStart,
      this.loopEnd,
      final Set<int> waitingForNotes = const <int>{}})
      : _waitingForNotes = waitingForNotes,
        super._();

  @override
  @JsonKey()
  final PlaybackStatus status;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey()
  final Duration progress;
  @override
  @JsonKey()
  final PracticeMode practiceMode;
  @override
  @JsonKey()
  final HandIsolation handIsolation;
  @override
  @JsonKey()
  final bool isLooping;
  @override
  final Duration? loopStart;
  @override
  final Duration? loopEnd;
  final Set<int> _waitingForNotes;
  @override
  @JsonKey()
  Set<int> get waitingForNotes {
    if (_waitingForNotes is EqualUnmodifiableSetView) return _waitingForNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_waitingForNotes);
  }

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaybackStateCopyWith<_PlaybackState> get copyWith =>
      __$PlaybackStateCopyWithImpl<_PlaybackState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlaybackState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.practiceMode, practiceMode) ||
                other.practiceMode == practiceMode) &&
            (identical(other.handIsolation, handIsolation) ||
                other.handIsolation == handIsolation) &&
            (identical(other.isLooping, isLooping) ||
                other.isLooping == isLooping) &&
            (identical(other.loopStart, loopStart) ||
                other.loopStart == loopStart) &&
            (identical(other.loopEnd, loopEnd) || other.loopEnd == loopEnd) &&
            const DeepCollectionEquality()
                .equals(other._waitingForNotes, _waitingForNotes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      speed,
      progress,
      practiceMode,
      handIsolation,
      isLooping,
      loopStart,
      loopEnd,
      const DeepCollectionEquality().hash(_waitingForNotes));

  @override
  String toString() {
    return 'PlaybackState(status: $status, speed: $speed, progress: $progress, practiceMode: $practiceMode, handIsolation: $handIsolation, isLooping: $isLooping, loopStart: $loopStart, loopEnd: $loopEnd, waitingForNotes: $waitingForNotes)';
  }
}

/// @nodoc
abstract mixin class _$PlaybackStateCopyWith<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  factory _$PlaybackStateCopyWith(
          _PlaybackState value, $Res Function(_PlaybackState) _then) =
      __$PlaybackStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {PlaybackStatus status,
      double speed,
      Duration progress,
      PracticeMode practiceMode,
      HandIsolation handIsolation,
      bool isLooping,
      Duration? loopStart,
      Duration? loopEnd,
      Set<int> waitingForNotes});
}

/// @nodoc
class __$PlaybackStateCopyWithImpl<$Res>
    implements _$PlaybackStateCopyWith<$Res> {
  __$PlaybackStateCopyWithImpl(this._self, this._then);

  final _PlaybackState _self;
  final $Res Function(_PlaybackState) _then;

  /// Create a copy of PlaybackState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? speed = null,
    Object? progress = null,
    Object? practiceMode = null,
    Object? handIsolation = null,
    Object? isLooping = null,
    Object? loopStart = freezed,
    Object? loopEnd = freezed,
    Object? waitingForNotes = null,
  }) {
    return _then(_PlaybackState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlaybackStatus,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      progress: null == progress
          ? _self.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Duration,
      practiceMode: null == practiceMode
          ? _self.practiceMode
          : practiceMode // ignore: cast_nullable_to_non_nullable
              as PracticeMode,
      handIsolation: null == handIsolation
          ? _self.handIsolation
          : handIsolation // ignore: cast_nullable_to_non_nullable
              as HandIsolation,
      isLooping: null == isLooping
          ? _self.isLooping
          : isLooping // ignore: cast_nullable_to_non_nullable
              as bool,
      loopStart: freezed == loopStart
          ? _self.loopStart
          : loopStart // ignore: cast_nullable_to_non_nullable
              as Duration?,
      loopEnd: freezed == loopEnd
          ? _self.loopEnd
          : loopEnd // ignore: cast_nullable_to_non_nullable
              as Duration?,
      waitingForNotes: null == waitingForNotes
          ? _self._waitingForNotes
          : waitingForNotes // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

// dart format on
