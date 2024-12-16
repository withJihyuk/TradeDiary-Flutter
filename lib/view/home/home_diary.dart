part of '../home/home_page.dart';

class _DiaryList extends StatelessWidget {
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
            return const Center(
              child: Text("일기가 없습니다."),
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
                            contentImage: diaryList[index].image),
                        const SizedBox(height: 24),
                        (diaryList.length == index + 1)
                            ? const SizedBox(
                                height: 1,
                              )
                            : const Divider(
                                height: 1,
                                color: DiaryMainGrey.grey50,
                              ) // 월별 표기 필요
                      ],
                    ),
                  ])));
        });
  }
}
