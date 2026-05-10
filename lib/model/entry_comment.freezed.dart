// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EntryCommentModel _$EntryCommentModelFromJson(Map<String, dynamic> json) {
  return _EntryCommentModel.fromJson(json);
}

/// @nodoc
mixin _$EntryCommentModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'share_id')
  String get shareId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'hidden_at')
  DateTime? get hiddenAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'hidden_by')
  String? get hiddenBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EntryCommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryCommentModelCopyWith<EntryCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCommentModelCopyWith<$Res> {
  factory $EntryCommentModelCopyWith(
          EntryCommentModel value, $Res Function(EntryCommentModel) then) =
      _$EntryCommentModelCopyWithImpl<$Res, EntryCommentModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'share_id') String shareId,
      @JsonKey(name: 'user_id') String userId,
      String body,
      @JsonKey(name: 'hidden_at') DateTime? hiddenAt,
      @JsonKey(name: 'hidden_by') String? hiddenBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$EntryCommentModelCopyWithImpl<$Res, $Val extends EntryCommentModel>
    implements $EntryCommentModelCopyWith<$Res> {
  _$EntryCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shareId = null,
    Object? userId = null,
    Object? body = null,
    Object? hiddenAt = freezed,
    Object? hiddenBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shareId: null == shareId
          ? _value.shareId
          : shareId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      hiddenAt: freezed == hiddenAt
          ? _value.hiddenAt
          : hiddenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hiddenBy: freezed == hiddenBy
          ? _value.hiddenBy
          : hiddenBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$EntryCommentModelImplCopyWith<$Res>
    implements $EntryCommentModelCopyWith<$Res> {
  factory _$$EntryCommentModelImplCopyWith(_$EntryCommentModelImpl value,
          $Res Function(_$EntryCommentModelImpl) then) =
      __$$EntryCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'share_id') String shareId,
      @JsonKey(name: 'user_id') String userId,
      String body,
      @JsonKey(name: 'hidden_at') DateTime? hiddenAt,
      @JsonKey(name: 'hidden_by') String? hiddenBy,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$EntryCommentModelImplCopyWithImpl<$Res>
    extends _$EntryCommentModelCopyWithImpl<$Res, _$EntryCommentModelImpl>
    implements _$$EntryCommentModelImplCopyWith<$Res> {
  __$$EntryCommentModelImplCopyWithImpl(_$EntryCommentModelImpl _value,
      $Res Function(_$EntryCommentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shareId = null,
    Object? userId = null,
    Object? body = null,
    Object? hiddenAt = freezed,
    Object? hiddenBy = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EntryCommentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      shareId: null == shareId
          ? _value.shareId
          : shareId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      hiddenAt: freezed == hiddenAt
          ? _value.hiddenAt
          : hiddenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hiddenBy: freezed == hiddenBy
          ? _value.hiddenBy
          : hiddenBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$EntryCommentModelImpl implements _EntryCommentModel {
  _$EntryCommentModelImpl(
      {required this.id,
      @JsonKey(name: 'share_id') required this.shareId,
      @JsonKey(name: 'user_id') required this.userId,
      required this.body,
      @JsonKey(name: 'hidden_at') this.hiddenAt,
      @JsonKey(name: 'hidden_by') this.hiddenBy,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$EntryCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryCommentModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'share_id')
  final String shareId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String body;
  @override
  @JsonKey(name: 'hidden_at')
  final DateTime? hiddenAt;
  @override
  @JsonKey(name: 'hidden_by')
  final String? hiddenBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EntryCommentModel(id: $id, shareId: $shareId, userId: $userId, body: $body, hiddenAt: $hiddenAt, hiddenBy: $hiddenBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shareId, shareId) || other.shareId == shareId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.hiddenAt, hiddenAt) ||
                other.hiddenAt == hiddenAt) &&
            (identical(other.hiddenBy, hiddenBy) ||
                other.hiddenBy == hiddenBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, shareId, userId, body,
      hiddenAt, hiddenBy, createdAt, updatedAt);

  /// Create a copy of EntryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryCommentModelImplCopyWith<_$EntryCommentModelImpl> get copyWith =>
      __$$EntryCommentModelImplCopyWithImpl<_$EntryCommentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryCommentModelImplToJson(
      this,
    );
  }
}

abstract class _EntryCommentModel implements EntryCommentModel {
  factory _EntryCommentModel(
          {required final String id,
          @JsonKey(name: 'share_id') required final String shareId,
          @JsonKey(name: 'user_id') required final String userId,
          required final String body,
          @JsonKey(name: 'hidden_at') final DateTime? hiddenAt,
          @JsonKey(name: 'hidden_by') final String? hiddenBy,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'updated_at') final DateTime? updatedAt}) =
      _$EntryCommentModelImpl;

  factory _EntryCommentModel.fromJson(Map<String, dynamic> json) =
      _$EntryCommentModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'share_id')
  String get shareId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get body;
  @override
  @JsonKey(name: 'hidden_at')
  DateTime? get hiddenAt;
  @override
  @JsonKey(name: 'hidden_by')
  String? get hiddenBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of EntryCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryCommentModelImplCopyWith<_$EntryCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
