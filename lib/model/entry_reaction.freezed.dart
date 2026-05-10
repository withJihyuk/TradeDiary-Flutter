// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_reaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EntryReactionModel _$EntryReactionModelFromJson(Map<String, dynamic> json) {
  return _EntryReactionModel.fromJson(json);
}

/// @nodoc
mixin _$EntryReactionModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'share_id')
  String get shareId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get reaction => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this EntryReactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryReactionModelCopyWith<EntryReactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryReactionModelCopyWith<$Res> {
  factory $EntryReactionModelCopyWith(
          EntryReactionModel value, $Res Function(EntryReactionModel) then) =
      _$EntryReactionModelCopyWithImpl<$Res, EntryReactionModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'share_id') String shareId,
      @JsonKey(name: 'user_id') String userId,
      String reaction,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$EntryReactionModelCopyWithImpl<$Res, $Val extends EntryReactionModel>
    implements $EntryReactionModelCopyWith<$Res> {
  _$EntryReactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shareId = null,
    Object? userId = null,
    Object? reaction = null,
    Object? createdAt = freezed,
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
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntryReactionModelImplCopyWith<$Res>
    implements $EntryReactionModelCopyWith<$Res> {
  factory _$$EntryReactionModelImplCopyWith(_$EntryReactionModelImpl value,
          $Res Function(_$EntryReactionModelImpl) then) =
      __$$EntryReactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'share_id') String shareId,
      @JsonKey(name: 'user_id') String userId,
      String reaction,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$EntryReactionModelImplCopyWithImpl<$Res>
    extends _$EntryReactionModelCopyWithImpl<$Res, _$EntryReactionModelImpl>
    implements _$$EntryReactionModelImplCopyWith<$Res> {
  __$$EntryReactionModelImplCopyWithImpl(_$EntryReactionModelImpl _value,
      $Res Function(_$EntryReactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? shareId = null,
    Object? userId = null,
    Object? reaction = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$EntryReactionModelImpl(
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
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryReactionModelImpl implements _EntryReactionModel {
  _$EntryReactionModelImpl(
      {required this.id,
      @JsonKey(name: 'share_id') required this.shareId,
      @JsonKey(name: 'user_id') required this.userId,
      this.reaction = 'heart',
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$EntryReactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryReactionModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'share_id')
  final String shareId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey()
  final String reaction;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'EntryReactionModel(id: $id, shareId: $shareId, userId: $userId, reaction: $reaction, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryReactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shareId, shareId) || other.shareId == shareId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, shareId, userId, reaction, createdAt);

  /// Create a copy of EntryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryReactionModelImplCopyWith<_$EntryReactionModelImpl> get copyWith =>
      __$$EntryReactionModelImplCopyWithImpl<_$EntryReactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryReactionModelImplToJson(
      this,
    );
  }
}

abstract class _EntryReactionModel implements EntryReactionModel {
  factory _EntryReactionModel(
          {required final String id,
          @JsonKey(name: 'share_id') required final String shareId,
          @JsonKey(name: 'user_id') required final String userId,
          final String reaction,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$EntryReactionModelImpl;

  factory _EntryReactionModel.fromJson(Map<String, dynamic> json) =
      _$EntryReactionModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'share_id')
  String get shareId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get reaction;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of EntryReactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryReactionModelImplCopyWith<_$EntryReactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
