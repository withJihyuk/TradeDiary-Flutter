import 'package:flutter_test/flutter_test.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/profile.dart';

void main() {
  test('generated models serialize and copy values', () {
    final diary = DiaryPostModel(
      userId: 'user',
      subject: 'subject',
      content: 'content',
      emotion: 'happy',
    );
    final copiedDiary = diary.copyWith(subject: 'updated');

    expect(DiaryPostModel.fromJson(copiedDiary.toJson()), copiedDiary);
    expect(copiedDiary.toJson(), isNot(contains('id')));

    final profile = ProfileModel(
      id: 'user',
      nickname: 'potato',
      level: 1,
      exp: 10,
    );

    expect(ProfileModel.fromJson(profile.toJson()), profile);
  });
}
