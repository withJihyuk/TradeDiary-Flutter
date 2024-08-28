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
  String get profile_url => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get terms_flag => throw _privateConstructorUsedError;
  bool get privacy_flag => throw _privateConstructorUsedError;
  DateTime get birth => throw _privateConstructorUsedError;

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
      String profile_url,
      String gender,
      String email,
      bool terms_flag,
      bool privacy_flag,
      DateTime birth});
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
    Object? profile_url = null,
    Object? gender = null,
    Object? email = null,
    Object? terms_flag = null,
    Object? privacy_flag = null,
    Object? birth = null,
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
      profile_url: null == profile_url
          ? _value.profile_url
          : profile_url // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      terms_flag: null == terms_flag
          ? _value.terms_flag
          : terms_flag // ignore: cast_nullable_to_non_nullable
              as bool,
      privacy_flag: null == privacy_flag
          ? _value.privacy_flag
          : privacy_flag // ignore: cast_nullable_to_non_nullable
              as bool,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      String profile_url,
      String gender,
      String email,
      bool terms_flag,
      bool privacy_flag,
      DateTime birth});
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
    Object? profile_url = null,
    Object? gender = null,
    Object? email = null,
    Object? terms_flag = null,
    Object? privacy_flag = null,
    Object? birth = null,
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
      profile_url: null == profile_url
          ? _value.profile_url
          : profile_url // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      terms_flag: null == terms_flag
          ? _value.terms_flag
          : terms_flag // ignore: cast_nullable_to_non_nullable
              as bool,
      privacy_flag: null == privacy_flag
          ? _value.privacy_flag
          : privacy_flag // ignore: cast_nullable_to_non_nullable
              as bool,
      birth: null == birth
          ? _value.birth
          : birth // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl implements _UserProfileModel {
  _$UserProfileModelImpl(
      {required this.id,
      required this.nickname,
      required this.profile_url,
      required this.gender,
      required this.email,
      required this.terms_flag,
      required this.privacy_flag,
      required this.birth});

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String nickname;
  @override
  final String profile_url;
  @override
  final String gender;
  @override
  final String email;
  @override
  final bool terms_flag;
  @override
  final bool privacy_flag;
  @override
  final DateTime birth;

  @override
  String toString() {
    return 'UserProfileModel(id: $id, nickname: $nickname, profile_url: $profile_url, gender: $gender, email: $email, terms_flag: $terms_flag, privacy_flag: $privacy_flag, birth: $birth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profile_url, profile_url) ||
                other.profile_url == profile_url) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.terms_flag, terms_flag) ||
                other.terms_flag == terms_flag) &&
            (identical(other.privacy_flag, privacy_flag) ||
                other.privacy_flag == privacy_flag) &&
            (identical(other.birth, birth) || other.birth == birth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, nickname, profile_url,
      gender, email, terms_flag, privacy_flag, birth);

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
      required final String profile_url,
      required final String gender,
      required final String email,
      required final bool terms_flag,
      required final bool privacy_flag,
      required final DateTime birth}) = _$UserProfileModelImpl;

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get nickname;
  @override
  String get profile_url;
  @override
  String get gender;
  @override
  String get email;
  @override
  bool get terms_flag;
  @override
  bool get privacy_flag;
  @override
  DateTime get birth;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
