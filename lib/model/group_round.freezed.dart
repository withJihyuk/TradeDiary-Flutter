// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_round.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupRoundModel _$GroupRoundModelFromJson(Map<String, dynamic> json) {
  return _GroupRoundModel.fromJson(json);
}

/// @nodoc
mixin _$GroupRoundModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'round_date')
  DateTime get roundDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'deadline_at')
  DateTime get deadlineAt => throw _privateConstructorUsedError;
  GroupRoundStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this GroupRoundModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupRoundModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupRoundModelCopyWith<GroupRoundModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupRoundModelCopyWith<$Res> {
  factory $GroupRoundModelCopyWith(
          GroupRoundModel value, $Res Function(GroupRoundModel) then) =
      _$GroupRoundModelCopyWithImpl<$Res, GroupRoundModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'round_date') DateTime roundDate,
      @JsonKey(name: 'deadline_at') DateTime deadlineAt,
      GroupRoundStatus status,
      @JsonKey(name: 'published_at') DateTime? publishedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$GroupRoundModelCopyWithImpl<$Res, $Val extends GroupRoundModel>
    implements $GroupRoundModelCopyWith<$Res> {
  _$GroupRoundModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupRoundModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? roundDate = null,
    Object? deadlineAt = null,
    Object? status = null,
    Object? publishedAt = freezed,
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
      roundDate: null == roundDate
          ? _value.roundDate
          : roundDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deadlineAt: null == deadlineAt
          ? _value.deadlineAt
          : deadlineAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GroupRoundStatus,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupRoundModelImplCopyWith<$Res>
    implements $GroupRoundModelCopyWith<$Res> {
  factory _$$GroupRoundModelImplCopyWith(_$GroupRoundModelImpl value,
          $Res Function(_$GroupRoundModelImpl) then) =
      __$$GroupRoundModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'group_id') String groupId,
      @JsonKey(name: 'round_date') DateTime roundDate,
      @JsonKey(name: 'deadline_at') DateTime deadlineAt,
      GroupRoundStatus status,
      @JsonKey(name: 'published_at') DateTime? publishedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$GroupRoundModelImplCopyWithImpl<$Res>
    extends _$GroupRoundModelCopyWithImpl<$Res, _$GroupRoundModelImpl>
    implements _$$GroupRoundModelImplCopyWith<$Res> {
  __$$GroupRoundModelImplCopyWithImpl(
      _$GroupRoundModelImpl _value, $Res Function(_$GroupRoundModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupRoundModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? roundDate = null,
    Object? deadlineAt = null,
    Object? status = null,
    Object? publishedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$GroupRoundModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      roundDate: null == roundDate
          ? _value.roundDate
          : roundDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deadlineAt: null == deadlineAt
          ? _value.deadlineAt
          : deadlineAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GroupRoundStatus,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
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
class _$GroupRoundModelImpl implements _GroupRoundModel {
  _$GroupRoundModelImpl(
      {required this.id,
      @JsonKey(name: 'group_id') required this.groupId,
      @JsonKey(name: 'round_date') required this.roundDate,
      @JsonKey(name: 'deadline_at') required this.deadlineAt,
      this.status = GroupRoundStatus.open,
      @JsonKey(name: 'published_at') this.publishedAt,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$GroupRoundModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupRoundModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'round_date')
  final DateTime roundDate;
  @override
  @JsonKey(name: 'deadline_at')
  final DateTime deadlineAt;
  @override
  @JsonKey()
  final GroupRoundStatus status;
  @override
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GroupRoundModel(id: $id, groupId: $groupId, roundDate: $roundDate, deadlineAt: $deadlineAt, status: $status, publishedAt: $publishedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupRoundModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.roundDate, roundDate) ||
                other.roundDate == roundDate) &&
            (identical(other.deadlineAt, deadlineAt) ||
                other.deadlineAt == deadlineAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, groupId, roundDate,
      deadlineAt, status, publishedAt, createdAt);

  /// Create a copy of GroupRoundModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupRoundModelImplCopyWith<_$GroupRoundModelImpl> get copyWith =>
      __$$GroupRoundModelImplCopyWithImpl<_$GroupRoundModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupRoundModelImplToJson(
      this,
    );
  }
}

abstract class _GroupRoundModel implements GroupRoundModel {
  factory _GroupRoundModel(
          {required final String id,
          @JsonKey(name: 'group_id') required final String groupId,
          @JsonKey(name: 'round_date') required final DateTime roundDate,
          @JsonKey(name: 'deadline_at') required final DateTime deadlineAt,
          final GroupRoundStatus status,
          @JsonKey(name: 'published_at') final DateTime? publishedAt,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$GroupRoundModelImpl;

  factory _GroupRoundModel.fromJson(Map<String, dynamic> json) =
      _$GroupRoundModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'round_date')
  DateTime get roundDate;
  @override
  @JsonKey(name: 'deadline_at')
  DateTime get deadlineAt;
  @override
  GroupRoundStatus get status;
  @override
  @JsonKey(name: 'published_at')
  DateTime? get publishedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of GroupRoundModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupRoundModelImplCopyWith<_$GroupRoundModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
