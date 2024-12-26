part of 'diary_page.dart';

// 아이콘 반영 필요
// 월별 표기 필요
class _DiaryList extends StatelessWidget {
  // ignore: unused_element
  const _DiaryList({super.key, required this.diaryList});
  final Future<List<DiaryPostModel>> diaryList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DiaryPostModel>>(
      future: diaryList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image:
                      AssetImage('assets/images/character/img-potato-sad.png'),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  "아직 일기가 없어요",
                  style: AppTextStyle.h4Semi
                      .copyWith(color: DiaryColor.globalMainColor),
                ),
                Text(
                  "하단의 버튼을 눌러 일기를 작성해 보세요!",
                  style: AppTextStyle.m3Regular
                      .copyWith(color: DiaryMainGrey.grey800),
                ),
              ],
            ),
          );
        } else {
          final diaryList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: diaryList.length,
            itemBuilder: (context, index) {
              final diary = diaryList[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      DiaryHomeContentRead(
                        contentName: diary.subject,
                        contentDate: "${diary.date.month}/${diary.date.day}",
                        contentPreview: diary.content,
                        contentEmotion: diary.emotion,
                        onTap: () => PageRouter.router
                            .push("/read/$index", extra: diaryList),
                      ),
                      const SizedBox(height: 24),
                      if (index < diaryList.length - 1)
                        const Divider(height: 1, color: DiaryMainGrey.grey50),
                    ],
                  ));
            },
          );
        }
      },
    );
  }
}
