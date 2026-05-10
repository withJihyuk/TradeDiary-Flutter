// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) {
  return _GroupMemberModel.fromJson(json);
}

/// @nodoc
mixin _$GroupMemberModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  GroupMemberRole get role => throw _privateConstructorUsedError;
  GroupMemberStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'left_at')
  DateTime? get leftAt => throw _privateConstructorUsedError;

  /// Serializes this GroupMemberModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupMemberModelCopyWith<GroupMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupMemberModelCopyWith<$Res> {
  factory $GroupMemberModelCopyWith(
          GroupMemberModel value, $Res Function(GroupMemberModel) then) =
      _$GroupMemberModelCopyWithImpl<$Res, GroupMemberModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'user_id') String userId,
      GroupMemberRole role,
      GroupMemberStatus status,
      @JsonKey(name: 'joined_at') DateTime? joinedAt,
      @JsonKey(name: 'left_at') DateTime? leftAt});
}

/// @nodoc
class _$GroupMemberModelCopyWithImpl<$Res, $Val extends GroupMemberModel>
    implements $GroupMemberModelCopyWith<$Res> {
  _$GroupMemberModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? joinedAt = freezed,
    Object? leftAt = freezed,
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
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as GroupMemberRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GroupMemberStatus,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leftAt: freezed == leftAt
          ? _value.leftAt
          : leftAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupMemberModelImplCopyWith<$Res>
    implements $GroupMemberModelCopyWith<$Res> {
  factory _$$GroupMemberModelImplCopyWith(_$GroupMemberModelImpl value,
          $Res Function(_$GroupMemberModelImpl) then) =
      __$$GroupMemberModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'user_id') String userId,
      GroupMemberRole role,
      GroupMemberStatus status,
      @JsonKey(name: 'joined_at') DateTime? joinedAt,
      @JsonKey(name: 'left_at') DateTime? leftAt});
}

/// @nodoc
class __$$GroupMemberModelImplCopyWithImpl<$Res>
    extends _$GroupMemberModelCopyWithImpl<$Res, _$GroupMemberModelImpl>
    implements _$$GroupMemberModelImplCopyWith<$Res> {
  __$$GroupMemberModelImplCopyWithImpl(_$GroupMemberModelImpl _value,
      $Res Function(_$GroupMemberModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? userId = null,
    Object? role = null,
    Object? status = null,
    Object? joinedAt = freezed,
    Object? leftAt = freezed,
  }) {
    return _then(_$GroupMemberModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as GroupMemberRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GroupMemberStatus,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leftAt: freezed == leftAt
          ? _value.leftAt
          : leftAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupMemberModelImpl implements _GroupMemberModel {
  _$GroupMemberModelImpl(
      {required this.id,
      @JsonKey(name: 'group_id') required this.groupId,
      @JsonKey(name: 'user_id') required this.userId,
      this.role = GroupMemberRole.member,
      this.status = GroupMemberStatus.active,
      @JsonKey(name: 'joined_at') this.joinedAt,
      @JsonKey(name: 'left_at') this.leftAt});

  factory _$GroupMemberModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupMemberModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final GroupMemberRole role;
  @override
  @JsonKey()
  final GroupMemberStatus status;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime? joinedAt;
  @override
  @JsonKey(name: 'left_at')
  final DateTime? leftAt;

  @override
  String toString() {
    return 'GroupMemberModel(id: $id, groupId: $groupId, userId: $userId, role: $role, status: $status, joinedAt: $joinedAt, leftAt: $leftAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupMemberModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.leftAt, leftAt) || other.leftAt == leftAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, groupId, userId, role, status, joinedAt, leftAt);

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupMemberModelImplCopyWith<_$GroupMemberModelImpl> get copyWith =>
      __$$GroupMemberModelImplCopyWithImpl<_$GroupMemberModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupMemberModelImplToJson(
      this,
    );
  }
}

abstract class _GroupMemberModel implements GroupMemberModel {
  factory _GroupMemberModel(
          {required final String id,
          @JsonKey(name: 'group_id') required final String groupId,
          @JsonKey(name: 'user_id') required final String userId,
          final GroupMemberRole role,
          final GroupMemberStatus status,
          @JsonKey(name: 'joined_at') final DateTime? joinedAt,
          @JsonKey(name: 'left_at') final DateTime? leftAt}) =
      _$GroupMemberModelImpl;

  factory _GroupMemberModel.fromJson(Map<String, dynamic> json) =
      _$GroupMemberModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  GroupMemberRole get role;
  @override
  GroupMemberStatus get status;
  @override
  @JsonKey(name: 'joined_at')
  DateTime? get joinedAt;
  @override
  @JsonKey(name: 'left_at')
  DateTime? get leftAt;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupMemberModelImplCopyWith<_$GroupMemberModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
