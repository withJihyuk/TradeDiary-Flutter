// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get profileUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
          UserProfileModel value, $Res Function(UserProfileModel) then) =
      _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call(
      {String id,
      String nickname,
      String profileUrl,
      String description,
      bool isPrivate});
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? profileUrl = null,
    Object? description = null,
    Object? isPrivate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profileUrl: null == profileUrl
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(_$UserProfileModelImpl value,
          $Res Function(_$UserProfileModelImpl) then) =
      __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nickname,
      String profileUrl,
      String description,
      bool isPrivate});
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(_$UserProfileModelImpl _value,
      $Res Function(_$UserProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nickname = null,
    Object? profileUrl = null,
    Object? description = null,
    Object? isPrivate = null,
  }) {
    return _then(_$UserProfileModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profileUrl: null == profileUrl
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl implements _UserProfileModel {
  _$UserProfileModelImpl(
      {required this.id,
      required this.nickname,
      required this.profileUrl,
      required this.description,
      required this.isPrivate});

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String nickname;
  @override
  final String profileUrl;
  @override
  final String description;
  @override
  final bool isPrivate;

  @override
  String toString() {
    return 'UserProfileModel(id: $id, nickname: $nickname, profileUrl: $profileUrl, description: $description, isPrivate: $isPrivate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileUrl, profileUrl) ||
                other.profileUrl == profileUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, nickname, profileUrl, description, isPrivate);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(
      this,
    );
  }
}

abstract class _UserProfileModel implements UserProfileModel {
  factory _UserProfileModel(
      {required final String id,
      required final String nickname,
      required final String profileUrl,
      required final String description,
      required final bool isPrivate}) = _$UserProfileModelImpl;

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get nickname;
  @override
  String get profileUrl;
  @override
  String get description;
  @override
  bool get isPrivate;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
