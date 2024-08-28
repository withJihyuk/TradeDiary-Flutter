// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_follow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserFollowModel _$UserFollowModelFromJson(Map<String, dynamic> json) {
  return _UserFollowModel.fromJson(json);
}

/// @nodoc
mixin _$UserFollowModel {
  String get toUser => throw _privateConstructorUsedError;
  String get fromUser => throw _privateConstructorUsedError;

  /// Serializes this UserFollowModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserFollowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFollowModelCopyWith<UserFollowModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFollowModelCopyWith<$Res> {
  factory $UserFollowModelCopyWith(
          UserFollowModel value, $Res Function(UserFollowModel) then) =
      _$UserFollowModelCopyWithImpl<$Res, UserFollowModel>;
  @useResult
  $Res call({String toUser, String fromUser});
}

/// @nodoc
class _$UserFollowModelCopyWithImpl<$Res, $Val extends UserFollowModel>
    implements $UserFollowModelCopyWith<$Res> {
  _$UserFollowModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFollowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toUser = null,
    Object? fromUser = null,
  }) {
    return _then(_value.copyWith(
      toUser: null == toUser
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as String,
      fromUser: null == fromUser
          ? _value.fromUser
          : fromUser // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFollowModelImplCopyWith<$Res>
    implements $UserFollowModelCopyWith<$Res> {
  factory _$$UserFollowModelImplCopyWith(_$UserFollowModelImpl value,
          $Res Function(_$UserFollowModelImpl) then) =
      __$$UserFollowModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String toUser, String fromUser});
}

/// @nodoc
class __$$UserFollowModelImplCopyWithImpl<$Res>
    extends _$UserFollowModelCopyWithImpl<$Res, _$UserFollowModelImpl>
    implements _$$UserFollowModelImplCopyWith<$Res> {
  __$$UserFollowModelImplCopyWithImpl(
      _$UserFollowModelImpl _value, $Res Function(_$UserFollowModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserFollowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toUser = null,
    Object? fromUser = null,
  }) {
    return _then(_$UserFollowModelImpl(
      toUser: null == toUser
          ? _value.toUser
          : toUser // ignore: cast_nullable_to_non_nullable
              as String,
      fromUser: null == fromUser
          ? _value.fromUser
          : fromUser // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserFollowModelImpl implements _UserFollowModel {
  _$UserFollowModelImpl({required this.toUser, required this.fromUser});

  factory _$UserFollowModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserFollowModelImplFromJson(json);

  @override
  final String toUser;
  @override
  final String fromUser;

  @override
  String toString() {
    return 'UserFollowModel(toUser: $toUser, fromUser: $fromUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFollowModelImpl &&
            (identical(other.toUser, toUser) || other.toUser == toUser) &&
            (identical(other.fromUser, fromUser) ||
                other.fromUser == fromUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, toUser, fromUser);

  /// Create a copy of UserFollowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFollowModelImplCopyWith<_$UserFollowModelImpl> get copyWith =>
      __$$UserFollowModelImplCopyWithImpl<_$UserFollowModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserFollowModelImplToJson(
      this,
    );
  }
}

abstract class _UserFollowModel implements UserFollowModel {
  factory _UserFollowModel(
      {required final String toUser,
      required final String fromUser}) = _$UserFollowModelImpl;

  factory _UserFollowModel.fromJson(Map<String, dynamic> json) =
      _$UserFollowModelImpl.fromJson;

  @override
  String get toUser;
  @override
  String get fromUser;

  /// Create a copy of UserFollowModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFollowModelImplCopyWith<_$UserFollowModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
