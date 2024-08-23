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
  String get userId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;

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
  $Res call({String userId, String content, bool isPrivate});
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
    Object? userId = null,
    Object? content = null,
    Object? isPrivate = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({String userId, String content, bool isPrivate});
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
    Object? userId = null,
    Object? content = null,
    Object? isPrivate = null,
  }) {
    return _then(_$DiaryPostModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
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
class _$DiaryPostModelImpl implements _DiaryPostModel {
  _$DiaryPostModelImpl(
      {required this.userId, required this.content, required this.isPrivate});

  factory _$DiaryPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiaryPostModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String content;
  @override
  final bool isPrivate;

  @override
  String toString() {
    return 'DiaryPostModel(userId: $userId, content: $content, isPrivate: $isPrivate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryPostModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, content, isPrivate);

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
      {required final String userId,
      required final String content,
      required final bool isPrivate}) = _$DiaryPostModelImpl;

  factory _DiaryPostModel.fromJson(Map<String, dynamic> json) =
      _$DiaryPostModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get content;
  @override
  bool get isPrivate;

  /// Create a copy of DiaryPostModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiaryPostModelImplCopyWith<_$DiaryPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
