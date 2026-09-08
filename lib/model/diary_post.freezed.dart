// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiaryPostModel {

@JsonKey(includeToJson: false) String? get id; String get userId; String get subject; String get content; String get emotion;@JsonKey(includeToJson: false) bool get isDraft;@JsonKey(includeToJson: false) DateTime? get createdAt;@JsonKey(includeToJson: false) DateTime? get updatedAt;@JsonKey(includeToJson: false) DateTime? get completedAt;@JsonKey(includeToJson: false) String? get diaryDate;@JsonKey(includeToJson: false) int get revision;@JsonKey(includeToJson: false) String? get lastMutationId;
/// Create a copy of DiaryPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryPostModelCopyWith<DiaryPostModel> get copyWith => _$DiaryPostModelCopyWithImpl<DiaryPostModel>(this as DiaryPostModel, _$identity);

  /// Serializes this DiaryPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DiaryPostModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryPostModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.emotion, _this.emotion) || other.emotion == _this.emotion)&&(identical(other.isDraft, _this.isDraft) || other.isDraft == _this.isDraft)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.diaryDate, _this.diaryDate) || other.diaryDate == _this.diaryDate)&&(identical(other.revision, _this.revision) || other.revision == _this.revision)&&(identical(other.lastMutationId, _this.lastMutationId) || other.lastMutationId == _this.lastMutationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DiaryPostModel;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.subject,_this.content,_this.emotion,_this.isDraft,_this.createdAt,_this.updatedAt,_this.completedAt,_this.diaryDate,_this.revision,_this.lastMutationId);
}

@override
String toString() {
  final _this = this as DiaryPostModel;
  return 'DiaryPostModel(id: ${_this.id}, userId: ${_this.userId}, subject: ${_this.subject}, content: ${_this.content}, emotion: ${_this.emotion}, isDraft: ${_this.isDraft}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, completedAt: ${_this.completedAt}, diaryDate: ${_this.diaryDate}, revision: ${_this.revision}, lastMutationId: ${_this.lastMutationId})';
}


}

/// @nodoc
abstract mixin class $DiaryPostModelCopyWith<$Res>  {
  factory $DiaryPostModelCopyWith(DiaryPostModel value, $Res Function(DiaryPostModel) _then) = _$DiaryPostModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) String? id, String userId, String subject, String content, String emotion,@JsonKey(includeToJson: false) bool isDraft,@JsonKey(includeToJson: false) DateTime? createdAt,@JsonKey(includeToJson: false) DateTime? updatedAt,@JsonKey(includeToJson: false) DateTime? completedAt,@JsonKey(includeToJson: false) String? diaryDate,@JsonKey(includeToJson: false) int revision,@JsonKey(includeToJson: false) String? lastMutationId
});




}
/// @nodoc
class _$DiaryPostModelCopyWithImpl<$Res>
    implements $DiaryPostModelCopyWith<$Res> {
  _$DiaryPostModelCopyWithImpl(this._self, this._then);

  final DiaryPostModel _self;
  final $Res Function(DiaryPostModel) _then;

/// Create a copy of DiaryPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? subject = null,Object? content = null,Object? emotion = null,Object? isDraft = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,Object? diaryDate = freezed,Object? revision = null,Object? lastMutationId = freezed,}) {
  return _then(DiaryPostModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,emotion: null == emotion ? _self.emotion : emotion // ignore: cast_nullable_to_non_nullable
as String,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,diaryDate: freezed == diaryDate ? _self.diaryDate : diaryDate // ignore: cast_nullable_to_non_nullable
as String?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,lastMutationId: freezed == lastMutationId ? _self.lastMutationId : lastMutationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaryPostModel].
extension DiaryPostModelPatterns on DiaryPostModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryPostModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryPostModel value)  $default,){
final _that = this;
switch (_that) {
case _DiaryPostModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryPostModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String? id,  String userId,  String subject,  String content,  String emotion, @JsonKey(includeToJson: false)  bool isDraft, @JsonKey(includeToJson: false)  DateTime? createdAt, @JsonKey(includeToJson: false)  DateTime? updatedAt, @JsonKey(includeToJson: false)  DateTime? completedAt, @JsonKey(includeToJson: false)  String? diaryDate, @JsonKey(includeToJson: false)  int revision, @JsonKey(includeToJson: false)  String? lastMutationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryPostModel() when $default != null:
return $default(_that.id,_that.userId,_that.subject,_that.content,_that.emotion,_that.isDraft,_that.createdAt,_that.updatedAt,_that.completedAt,_that.diaryDate,_that.revision,_that.lastMutationId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  String? id,  String userId,  String subject,  String content,  String emotion, @JsonKey(includeToJson: false)  bool isDraft, @JsonKey(includeToJson: false)  DateTime? createdAt, @JsonKey(includeToJson: false)  DateTime? updatedAt, @JsonKey(includeToJson: false)  DateTime? completedAt, @JsonKey(includeToJson: false)  String? diaryDate, @JsonKey(includeToJson: false)  int revision, @JsonKey(includeToJson: false)  String? lastMutationId)  $default,) {final _that = this;
switch (_that) {
case _DiaryPostModel():
return $default(_that.id,_that.userId,_that.subject,_that.content,_that.emotion,_that.isDraft,_that.createdAt,_that.updatedAt,_that.completedAt,_that.diaryDate,_that.revision,_that.lastMutationId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  String? id,  String userId,  String subject,  String content,  String emotion, @JsonKey(includeToJson: false)  bool isDraft, @JsonKey(includeToJson: false)  DateTime? createdAt, @JsonKey(includeToJson: false)  DateTime? updatedAt, @JsonKey(includeToJson: false)  DateTime? completedAt, @JsonKey(includeToJson: false)  String? diaryDate, @JsonKey(includeToJson: false)  int revision, @JsonKey(includeToJson: false)  String? lastMutationId)?  $default,) {final _that = this;
switch (_that) {
case _DiaryPostModel() when $default != null:
return $default(_that.id,_that.userId,_that.subject,_that.content,_that.emotion,_that.isDraft,_that.createdAt,_that.updatedAt,_that.completedAt,_that.diaryDate,_that.revision,_that.lastMutationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiaryPostModel implements DiaryPostModel {
   _DiaryPostModel({@JsonKey(includeToJson: false) this.id, required this.userId, required this.subject, required this.content, required this.emotion, @JsonKey(includeToJson: false) this.isDraft = false, @JsonKey(includeToJson: false) this.createdAt, @JsonKey(includeToJson: false) this.updatedAt, @JsonKey(includeToJson: false) this.completedAt, @JsonKey(includeToJson: false) this.diaryDate, @JsonKey(includeToJson: false) this.revision = 0, @JsonKey(includeToJson: false) this.lastMutationId});
  factory _DiaryPostModel.fromJson(Map<String, dynamic> json) => _$DiaryPostModelFromJson(json);

@override@JsonKey(includeToJson: false) final  String? id;
@override final  String userId;
@override final  String subject;
@override final  String content;
@override final  String emotion;
@override@JsonKey(includeToJson: false) final  bool isDraft;
@override@JsonKey(includeToJson: false) final  DateTime? createdAt;
@override@JsonKey(includeToJson: false) final  DateTime? updatedAt;
@override@JsonKey(includeToJson: false) final  DateTime? completedAt;
@override@JsonKey(includeToJson: false) final  String? diaryDate;
@override@JsonKey(includeToJson: false) final  int revision;
@override@JsonKey(includeToJson: false) final  String? lastMutationId;

/// Create a copy of DiaryPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryPostModelCopyWith<_DiaryPostModel> get copyWith => __$DiaryPostModelCopyWithImpl<_DiaryPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiaryPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.content, content) || other.content == content)&&(identical(other.emotion, emotion) || other.emotion == emotion)&&(identical(other.isDraft, isDraft) || other.isDraft == isDraft)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.diaryDate, diaryDate) || other.diaryDate == diaryDate)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.lastMutationId, lastMutationId) || other.lastMutationId == lastMutationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,subject,content,emotion,isDraft,createdAt,updatedAt,completedAt,diaryDate,revision,lastMutationId);
}

@override
String toString() {
    return 'DiaryPostModel(id: $id, userId: $userId, subject: $subject, content: $content, emotion: $emotion, isDraft: $isDraft, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, diaryDate: $diaryDate, revision: $revision, lastMutationId: $lastMutationId)';
}


}

/// @nodoc
abstract mixin class _$DiaryPostModelCopyWith<$Res> implements $DiaryPostModelCopyWith<$Res> {
  factory _$DiaryPostModelCopyWith(_DiaryPostModel value, $Res Function(_DiaryPostModel) _then) = __$DiaryPostModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) String? id, String userId, String subject, String content, String emotion,@JsonKey(includeToJson: false) bool isDraft,@JsonKey(includeToJson: false) DateTime? createdAt,@JsonKey(includeToJson: false) DateTime? updatedAt,@JsonKey(includeToJson: false) DateTime? completedAt,@JsonKey(includeToJson: false) String? diaryDate,@JsonKey(includeToJson: false) int revision,@JsonKey(includeToJson: false) String? lastMutationId
});




}
/// @nodoc
class __$DiaryPostModelCopyWithImpl<$Res>
    implements _$DiaryPostModelCopyWith<$Res> {
  __$DiaryPostModelCopyWithImpl(this._self, this._then);

  final _DiaryPostModel _self;
  final $Res Function(_DiaryPostModel) _then;

/// Create a copy of DiaryPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? subject = null,Object? content = null,Object? emotion = null,Object? isDraft = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? completedAt = freezed,Object? diaryDate = freezed,Object? revision = null,Object? lastMutationId = freezed,}) {
  return _then(_DiaryPostModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,emotion: null == emotion ? _self.emotion : emotion // ignore: cast_nullable_to_non_nullable
as String,isDraft: null == isDraft ? _self.isDraft : isDraft // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,diaryDate: freezed == diaryDate ? _self.diaryDate : diaryDate // ignore: cast_nullable_to_non_nullable
as String?,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,lastMutationId: freezed == lastMutationId ? _self.lastMutationId : lastMutationId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
