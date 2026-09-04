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
  @JsonKey(includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get emotion => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  bool get isDraft => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      {@JsonKey(includeToJson: false) String? id,
      String userId,
      String subject,
      String content,
      String emotion,
      @JsonKey(includeToJson: false) bool isDraft,
      @JsonKey(includeToJson: false) DateTime? createdAt,
      @JsonKey(includeToJson: false) DateTime? updatedAt});
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
    Object? userId = null,
    Object? subject = null,
    Object? content = null,
    Object? emotion = null,
    Object? isDraft = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emotion: null == emotion
          ? _value.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as String,
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$DiaryPostModelImplCopyWith<$Res>
    implements $DiaryPostModelCopyWith<$Res> {
  factory _$$DiaryPostModelImplCopyWith(_$DiaryPostModelImpl value,
          $Res Function(_$DiaryPostModelImpl) then) =
      __$$DiaryPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String? id,
      String userId,
      String subject,
      String content,
      String emotion,
      @JsonKey(includeToJson: false) bool isDraft,
      @JsonKey(includeToJson: false) DateTime? createdAt,
      @JsonKey(includeToJson: false) DateTime? updatedAt});
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
    Object? userId = null,
    Object? subject = null,
    Object? content = null,
    Object? emotion = null,
    Object? isDraft = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DiaryPostModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      emotion: null == emotion
          ? _value.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as String,
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$DiaryPostModelImpl implements _DiaryPostModel {
  _$DiaryPostModelImpl(
      {@JsonKey(includeToJson: false) this.id,
      required this.userId,
      required this.subject,
      required this.content,
      required this.emotion,
      @JsonKey(includeToJson: false) this.isDraft = false,
      @JsonKey(includeToJson: false) this.createdAt,
      @JsonKey(includeToJson: false) this.updatedAt});

  factory _$DiaryPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryPostModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String? id;
  @override
  final String userId;
  @override
  final String subject;
  @override
  final String content;
  @override
  final String emotion;
  @override
  @JsonKey(includeToJson: false)
  final bool isDraft;
  @override
  @JsonKey(includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(includeToJson: false)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DiaryPostModel(id: $id, userId: $userId, subject: $subject, content: $content, emotion: $emotion, isDraft: $isDraft, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryPostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.emotion, emotion) || other.emotion == emotion) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, subject, content,
      emotion, isDraft, createdAt, updatedAt);

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
          {@JsonKey(includeToJson: false) final String? id,
          required final String userId,
          required final String subject,
          required final String content,
          required final String emotion,
          @JsonKey(includeToJson: false) final bool isDraft,
          @JsonKey(includeToJson: false) final DateTime? createdAt,
          @JsonKey(includeToJson: false) final DateTime? updatedAt}) =
      _$DiaryPostModelImpl;

  factory _DiaryPostModel.fromJson(Map<String, dynamic> json) =
      _$DiaryPostModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String? get id;
  @override
  String get userId;
  @override
  String get subject;
  @override
  String get content;
  @override
  String get emotion;
  @override
  @JsonKey(includeToJson: false)
  bool get isDraft;
  @override
  @JsonKey(includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(includeToJson: false)
  DateTime? get updatedAt;

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiaryPostModelImplCopyWith<_$DiaryPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
