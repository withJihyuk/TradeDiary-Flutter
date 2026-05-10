// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_entry_share.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupEntryShareModel _$GroupEntryShareModelFromJson(Map<String, dynamic> json) {
  return _GroupEntryShareModel.fromJson(json);
}

/// @nodoc
mixin _$GroupEntryShareModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'round_id')
  String get roundId => throw _privateConstructorUsedError;
  @JsonKey(name: 'entry_id')
  String get entryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shared_at')
  DateTime get sharedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'canceled_at')
  DateTime? get canceledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupEntryShareModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupEntryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupEntryShareModelCopyWith<GroupEntryShareModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupEntryShareModelCopyWith<$Res> {
  factory $GroupEntryShareModelCopyWith(GroupEntryShareModel value,
          $Res Function(GroupEntryShareModel) then) =
      _$GroupEntryShareModelCopyWithImpl<$Res, GroupEntryShareModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'round_id') String roundId,
      @JsonKey(name: 'entry_id') String entryId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'shared_at') DateTime sharedAt,
      @JsonKey(name: 'canceled_at') DateTime? canceledAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$GroupEntryShareModelCopyWithImpl<$Res,
        $Val extends GroupEntryShareModel>
    implements $GroupEntryShareModelCopyWith<$Res> {
  _$GroupEntryShareModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupEntryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? roundId = null,
    Object? entryId = null,
    Object? userId = null,
    Object? sharedAt = null,
    Object? canceledAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      roundId: null == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String,
      entryId: null == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      canceledAt: freezed == canceledAt
          ? _value.canceledAt
          : canceledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupEntryShareModelImplCopyWith<$Res>
    implements $GroupEntryShareModelCopyWith<$Res> {
  factory _$$GroupEntryShareModelImplCopyWith(_$GroupEntryShareModelImpl value,
          $Res Function(_$GroupEntryShareModelImpl) then) =
      __$$GroupEntryShareModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'round_id') String roundId,
      @JsonKey(name: 'entry_id') String entryId,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'shared_at') DateTime sharedAt,
      @JsonKey(name: 'canceled_at') DateTime? canceledAt,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$GroupEntryShareModelImplCopyWithImpl<$Res>
    extends _$GroupEntryShareModelCopyWithImpl<$Res, _$GroupEntryShareModelImpl>
    implements _$$GroupEntryShareModelImplCopyWith<$Res> {
  __$$GroupEntryShareModelImplCopyWithImpl(_$GroupEntryShareModelImpl _value,
      $Res Function(_$GroupEntryShareModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupEntryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? roundId = null,
    Object? entryId = null,
    Object? userId = null,
    Object? sharedAt = null,
    Object? canceledAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$GroupEntryShareModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      roundId: null == roundId
          ? _value.roundId
          : roundId // ignore: cast_nullable_to_non_nullable
              as String,
      entryId: null == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      sharedAt: null == sharedAt
          ? _value.sharedAt
          : sharedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      canceledAt: freezed == canceledAt
          ? _value.canceledAt
          : canceledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupEntryShareModelImpl implements _GroupEntryShareModel {
  _$GroupEntryShareModelImpl(
      {required this.id,
      @JsonKey(name: 'group_id') required this.groupId,
      @JsonKey(name: 'round_id') required this.roundId,
      @JsonKey(name: 'entry_id') required this.entryId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'shared_at') required this.sharedAt,
      @JsonKey(name: 'canceled_at') this.canceledAt,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$GroupEntryShareModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupEntryShareModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'round_id')
  final String roundId;
  @override
  @JsonKey(name: 'entry_id')
  final String entryId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'shared_at')
  final DateTime sharedAt;
  @override
  @JsonKey(name: 'canceled_at')
  final DateTime? canceledAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GroupEntryShareModel(id: $id, groupId: $groupId, roundId: $roundId, entryId: $entryId, userId: $userId, sharedAt: $sharedAt, canceledAt: $canceledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupEntryShareModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.entryId, entryId) || other.entryId == entryId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.sharedAt, sharedAt) ||
                other.sharedAt == sharedAt) &&
            (identical(other.canceledAt, canceledAt) ||
                other.canceledAt == canceledAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, roundId, entryId,
      userId, sharedAt, canceledAt, createdAt, updatedAt);

  /// Create a copy of GroupEntryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupEntryShareModelImplCopyWith<_$GroupEntryShareModelImpl>
      get copyWith =>
          __$$GroupEntryShareModelImplCopyWithImpl<_$GroupEntryShareModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupEntryShareModelImplToJson(
      this,
    );
  }
}

abstract class _GroupEntryShareModel implements GroupEntryShareModel {
  factory _GroupEntryShareModel(
          {required final String id,
          @JsonKey(name: 'group_id') required final String groupId,
          @JsonKey(name: 'round_id') required final String roundId,
          @JsonKey(name: 'entry_id') required final String entryId,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'shared_at') required final DateTime sharedAt,
          @JsonKey(name: 'canceled_at') final DateTime? canceledAt,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$GroupEntryShareModelImpl;

  factory _GroupEntryShareModel.fromJson(Map<String, dynamic> json) =
      _$GroupEntryShareModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'round_id')
  String get roundId;
  @override
  @JsonKey(name: 'entry_id')
  String get entryId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'shared_at')
  DateTime get sharedAt;
  @override
  @JsonKey(name: 'canceled_at')
  DateTime? get canceledAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of GroupEntryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupEntryShareModelImplCopyWith<_$GroupEntryShareModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
