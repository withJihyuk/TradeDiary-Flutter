import 'package:pro_image_editor/pro_image_editor.dart';

class ImageEditorKorean {
  static const i18n = I18n(
    blurEditor: I18nBlurEditor(
      bottomNavigationBarText: "블러",
      done: "완료",
      back: "뒤로",
    ),
    stickerEditor: I18nStickerEditor(bottomNavigationBarText: "스티커"),
    emojiEditor: I18nEmojiEditor(
        bottomNavigationBarText: "이모지",
        search: "검색",
        categoryRecent: "최근",
        categorySmileys: "스마일리 & 사람",
        categoryAnimals: "동물 & 자연",
        categoryFood: "음식 & 음료",
        categoryActivities: "활동",
        categoryTravel: "여행 & 장소",
        categoryObjects: "사물",
        categorySymbols: "기호",
        categoryFlags: "깃발"),
    textEditor: I18nTextEditor(
        inputHintText: "텍스트 입력",
        bottomNavigationBarText: "텍스트",
        back: "뒤로",
        done: "완료",
        textAlign: "텍스트 정렬",
        fontScale: "글자 크기",
        backgroundMode: "배경 모드",
        smallScreenMoreTooltip: "더보기"),
    paintEditor: I18nPaintingEditor(
      bottomNavigationBarText: "그리기",
      arrow: "화살표",
      freestyle: '프리스타일',
      line: '선',
      rectangle: '사각형',
      circle: '원',
      dashLine: '점선',
      lineWidth: '선 두께',
      toggleFill: '채우기 전환',
      changeOpacity: '투명도 변경',
      eraser: '지우개',
      undo: '되돌리기',
      redo: '다시 실행',
      done: '완료',
      back: '뒤로',
    ),
  );
}
