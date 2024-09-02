// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UploadImageModel _$UploadImageModelFromJson(Map<String, dynamic> json) {
  return _UploadImageModel.fromJson(json);
}

/// @nodoc
mixin _$UploadImageModel {
  Uint8List? get image => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;

  /// Serializes this UploadImageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UploadImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UploadImageModelCopyWith<UploadImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadImageModelCopyWith<$Res> {
  factory $UploadImageModelCopyWith(
          UploadImageModel value, $Res Function(UploadImageModel) then) =
      _$UploadImageModelCopyWithImpl<$Res, UploadImageModel>;
  @useResult
  $Res call({Uint8List? image, String subject});
}

/// @nodoc
class _$UploadImageModelCopyWithImpl<$Res, $Val extends UploadImageModel>
    implements $UploadImageModelCopyWith<$Res> {
  _$UploadImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? subject = null,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UploadImageModelImplCopyWith<$Res>
    implements $UploadImageModelCopyWith<$Res> {
  factory _$$UploadImageModelImplCopyWith(_$UploadImageModelImpl value,
          $Res Function(_$UploadImageModelImpl) then) =
      __$$UploadImageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List? image, String subject});
}

/// @nodoc
class __$$UploadImageModelImplCopyWithImpl<$Res>
    extends _$UploadImageModelCopyWithImpl<$Res, _$UploadImageModelImpl>
    implements _$$UploadImageModelImplCopyWith<$Res> {
  __$$UploadImageModelImplCopyWithImpl(_$UploadImageModelImpl _value,
      $Res Function(_$UploadImageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UploadImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? subject = null,
  }) {
    return _then(_$UploadImageModelImpl(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@Uint8ListConverter()
class _$UploadImageModelImpl implements _UploadImageModel {
  _$UploadImageModelImpl({required this.image, required this.subject});

  factory _$UploadImageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UploadImageModelImplFromJson(json);

  @override
  final Uint8List? image;
  @override
  final String subject;

  @override
  String toString() {
    return 'UploadImageModel(image: $image, subject: $subject)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadImageModelImpl &&
            const DeepCollectionEquality().equals(other.image, image) &&
            (identical(other.subject, subject) || other.subject == subject));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(image), subject);

  /// Create a copy of UploadImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadImageModelImplCopyWith<_$UploadImageModelImpl> get copyWith =>
      __$$UploadImageModelImplCopyWithImpl<_$UploadImageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadImageModelImplToJson(
      this,
    );
  }
}

abstract class _UploadImageModel implements UploadImageModel {
  factory _UploadImageModel(
      {required final Uint8List? image,
      required final String subject}) = _$UploadImageModelImpl;

  factory _UploadImageModel.fromJson(Map<String, dynamic> json) =
      _$UploadImageModelImpl.fromJson;

  @override
  Uint8List? get image;
  @override
  String get subject;

  /// Create a copy of UploadImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadImageModelImplCopyWith<_$UploadImageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
