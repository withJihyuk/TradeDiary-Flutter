// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiaryPostModel _$DiaryPostModelFromJson(Map<String, dynamic> json) {
  return _DiaryPostModel.fromJson(json);
}

/// @nodoc
mixin _$DiaryPostModel {
  int? get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get deleteAt => throw _privateConstructorUsedError;
  int? get userId => throw _privateConstructorUsedError;

  /// Serializes this DiaryPostModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiaryPostModelCopyWith<DiaryPostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryPostModelCopyWith<$Res> {
  factory $DiaryPostModelCopyWith(
          DiaryPostModel value, $Res Function(DiaryPostModel) then) =
      _$DiaryPostModelCopyWithImpl<$Res, DiaryPostModel>;
  @useResult
  $Res call(
      {int? id,
      String? content,
      DateTime? createdAt,
      DateTime? deleteAt,
      int? userId});
}

/// @nodoc
class _$DiaryPostModelCopyWithImpl<$Res, $Val extends DiaryPostModel>
    implements $DiaryPostModelCopyWith<$Res> {
  _$DiaryPostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? deleteAt = freezed,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deleteAt: freezed == deleteAt
          ? _value.deleteAt
          : deleteAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiaryPostModelImplCopyWith<$Res>
    implements $DiaryPostModelCopyWith<$Res> {
  factory _$$DiaryPostModelImplCopyWith(_$DiaryPostModelImpl value,
          $Res Function(_$DiaryPostModelImpl) then) =
      __$$DiaryPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? content,
      DateTime? createdAt,
      DateTime? deleteAt,
      int? userId});
}

/// @nodoc
class __$$DiaryPostModelImplCopyWithImpl<$Res>
    extends _$DiaryPostModelCopyWithImpl<$Res, _$DiaryPostModelImpl>
    implements _$$DiaryPostModelImplCopyWith<$Res> {
  __$$DiaryPostModelImplCopyWithImpl(
      _$DiaryPostModelImpl _value, $Res Function(_$DiaryPostModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? createdAt = freezed,
    Object? deleteAt = freezed,
    Object? userId = freezed,
  }) {
    return _then(_$DiaryPostModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deleteAt: freezed == deleteAt
          ? _value.deleteAt
          : deleteAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiaryPostModelImpl implements _DiaryPostModel {
  _$DiaryPostModelImpl(
      {required this.id,
      required this.content,
      required this.createdAt,
      required this.deleteAt,
      required this.userId});

  factory _$DiaryPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryPostModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? content;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? deleteAt;
  @override
  final int? userId;

  @override
  String toString() {
    return 'DiaryPostModel(id: $id, content: $content, createdAt: $createdAt, deleteAt: $deleteAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryPostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deleteAt, deleteAt) ||
                other.deleteAt == deleteAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, createdAt, deleteAt, userId);

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryPostModelImplCopyWith<_$DiaryPostModelImpl> get copyWith =>
      __$$DiaryPostModelImplCopyWithImpl<_$DiaryPostModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiaryPostModelImplToJson(
      this,
    );
  }
}

abstract class _DiaryPostModel implements DiaryPostModel {
  factory _DiaryPostModel(
      {required final int? id,
      required final String? content,
      required final DateTime? createdAt,
      required final DateTime? deleteAt,
      required final int? userId}) = _$DiaryPostModelImpl;

  factory _DiaryPostModel.fromJson(Map<String, dynamic> json) =
      _$DiaryPostModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get content;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get deleteAt;
  @override
  int? get userId;

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiaryPostModelImplCopyWith<_$DiaryPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
