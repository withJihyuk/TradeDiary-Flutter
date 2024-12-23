part of 'diary_page.dart';

// 아이콘 반영 필요
// 월별 표기 필요

class _DiaryList extends StatelessWidget {
  // ignore: unused_element
  const _DiaryList({super.key, required this.diaryList});
  final List<DiaryPostModel> diaryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: diaryList.isEmpty ? 1 : diaryList.length,
        itemBuilder: (context, index) {
          if (diaryList.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Image(
                    image: AssetImage(
                        'assets/images/character/img-potato-sad.png'),
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "아직 일기가 없어요",
                    style: AppTextStyle.h4Semi
                        .copyWith(color: DiaryColor.globalMainColor),
                  ),
                  Text(
                    "하단의 버튼을 눌러 일기를 작성해 보세요!",
                    style: AppTextStyle.m3Regular
                        .copyWith(color: DiaryMainGrey.grey800),
                  )
                ],
              ),
            );
          }
          return ListTile(
              contentPadding: const EdgeInsets.all(0),
              minVerticalPadding: 0,
              title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(children: [
                    Column(
                      children: [
                        DiaryHomeContentRead(
                          contentName: diaryList[index].subject,
                          contentDate:
                              "${diaryList[index].date.month}/${diaryList[index].date.day}",
                          contentPreview: diaryList[index].content,
                          contentImage: diaryList[index].image.first,
                          onTap: () => PageRouter.router
                              .push("/read/$index", extra: diaryList),
                        ),
                        const SizedBox(height: 24),
                        (diaryList.length == index + 1)
                            ? const SizedBox(
                                height: 1,
                              )
                            : const Divider(
                                height: 1,
                                color: DiaryMainGrey.grey50,
                              )
                      ],
                    ),
                  ])));
        });
  }
}
