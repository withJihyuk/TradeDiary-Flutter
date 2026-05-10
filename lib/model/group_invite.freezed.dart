// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupInviteModel _$GroupInviteModelFromJson(Map<String, dynamic> json) {
  return _GroupInviteModel.fromJson(json);
}

/// @nodoc
mixin _$GroupInviteModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'revoked_at')
  DateTime? get revokedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GroupInviteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupInviteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupInviteModelCopyWith<GroupInviteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupInviteModelCopyWith<$Res> {
  factory $GroupInviteModelCopyWith(
          GroupInviteModel value, $Res Function(GroupInviteModel) then) =
      _$GroupInviteModelCopyWithImpl<$Res, GroupInviteModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      String code,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'revoked_at') DateTime? revokedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$GroupInviteModelCopyWithImpl<$Res, $Val extends GroupInviteModel>
    implements $GroupInviteModelCopyWith<$Res> {
  _$GroupInviteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupInviteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? code = null,
    Object? createdBy = null,
    Object? expiresAt = freezed,
    Object? revokedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revokedAt: freezed == revokedAt
          ? _value.revokedAt
          : revokedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupInviteModelImplCopyWith<$Res>
    implements $GroupInviteModelCopyWith<$Res> {
  factory _$$GroupInviteModelImplCopyWith(_$GroupInviteModelImpl value,
          $Res Function(_$GroupInviteModelImpl) then) =
      __$$GroupInviteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      String code,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'revoked_at') DateTime? revokedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$GroupInviteModelImplCopyWithImpl<$Res>
    extends _$GroupInviteModelCopyWithImpl<$Res, _$GroupInviteModelImpl>
    implements _$$GroupInviteModelImplCopyWith<$Res> {
  __$$GroupInviteModelImplCopyWithImpl(_$GroupInviteModelImpl _value,
      $Res Function(_$GroupInviteModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupInviteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? code = null,
    Object? createdBy = null,
    Object? expiresAt = freezed,
    Object? revokedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$GroupInviteModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      revokedAt: freezed == revokedAt
          ? _value.revokedAt
          : revokedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupInviteModelImpl implements _GroupInviteModel {
  _$GroupInviteModelImpl(
      {required this.id,
      @JsonKey(name: 'group_id') required this.groupId,
      required this.code,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'expires_at') this.expiresAt,
      @JsonKey(name: 'revoked_at') this.revokedAt,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$GroupInviteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupInviteModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  final String code;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'revoked_at')
  final DateTime? revokedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GroupInviteModel(id: $id, groupId: $groupId, code: $code, createdBy: $createdBy, expiresAt: $expiresAt, revokedAt: $revokedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupInviteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.revokedAt, revokedAt) ||
                other.revokedAt == revokedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, code, createdBy,
      expiresAt, revokedAt, createdAt);

  /// Create a copy of GroupInviteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupInviteModelImplCopyWith<_$GroupInviteModelImpl> get copyWith =>
      __$$GroupInviteModelImplCopyWithImpl<_$GroupInviteModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupInviteModelImplToJson(
      this,
    );
  }
}

abstract class _GroupInviteModel implements GroupInviteModel {
  factory _GroupInviteModel(
          {required final String id,
          @JsonKey(name: 'group_id') required final String groupId,
          required final String code,
          @JsonKey(name: 'created_by') required final String createdBy,
          @JsonKey(name: 'expires_at') final DateTime? expiresAt,
          @JsonKey(name: 'revoked_at') final DateTime? revokedAt,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$GroupInviteModelImpl;

  factory _GroupInviteModel.fromJson(Map<String, dynamic> json) =
      _$GroupInviteModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  String get code;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'revoked_at')
  DateTime? get revokedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of GroupInviteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupInviteModelImplCopyWith<_$GroupInviteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
