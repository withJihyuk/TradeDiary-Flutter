// Local artwork renderer. Run this entrypoint only on a capture simulator.
// It uses the production widgets with in-memory fixtures and no real account.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/designSystem/theme_data.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/provider/widget_update_provider.dart';
import 'package:trade_diary/provider/write_diary.dart';
import 'package:trade_diary/service/draft_store.dart';
import 'package:trade_diary/service/streak_service.dart';
import 'package:trade_diary/view/components/bottom_navigation_bar.dart';
import 'package:trade_diary/view/diary/diary_page.dart';
import 'package:trade_diary/view/diary/diary_view.dart';
import 'package:trade_diary/view/diary/draft_list_page.dart';
import 'package:trade_diary/view/home/home_page.dart';
import 'package:trade_diary/view/write/write_page.dart';
import 'package:trade_diary/view/write/write_selecting_emotion.dart';

const _profileId = '00000000-0000-4000-8000-000000000001';
final _profile = ProfileModel(
  id: _profileId,
  nickname: '몽실이',
  level: 3,
  exp: 42,
);
final _today = DateTime.now().toUtc().add(const Duration(hours: 9));
final _date = DateTime.utc(_today.year, _today.month, _today.day);
late List<DiaryPostModel> _diaries;
late List<LocalDraft> _drafts;
late ProviderContainer _container;
late GoRouter _router;
ui.Image? _editorScreenshot;

String _day(DateTime date) => date.toIso8601String().substring(0, 10);

DiaryPostModel _diary(int index, String title, String text, String emotion) {
  final date = _date.subtract(Duration(days: index));
  return DiaryPostModel(
    id: '00000000-0000-4000-8000-${(index + 100).toString().padLeft(12, '0')}',
    userId: _profileId,
    subject: title,
    content: text,
    emotion: emotion,
    diaryDate: _day(date),
    createdAt: date,
    updatedAt: date,
    completedAt: date,
  );
}

class _CaptureProfile extends ProfileNotifier {
  @override
  Future<void> loadProfile() async => state = AsyncData(_profile);
}

class _CaptureDiaries extends PaginatedDiaryNotifier {
  @override
  Future<void> loadInitial() async => setQuery('노을');

  @override
  void setQuery(String query) {
    state = PaginatedDiaryState(
      query: query,
      hasMore: false,
      items: _diaries
          .where((d) => d.subject.contains(query) || d.content.contains(query))
          .toList(),
    );
  }

  @override
  Future<void> loadMore() async {}
}

class _CaptureDrafts extends DraftStore {
  _CaptureDrafts() : super(null);

  @override
  List<LocalDraft> get drafts => _drafts;

  @override
  LocalDraft? get(String id) {
    for (final draft in _drafts) {
      if (draft.diary.id == id) return draft;
    }
    return null;
  }

  @override
  Future<DiaryPostModel?> open(String id) async => get(id)?.diary;

  @override
  Future<void> refresh() async {}

  @override
  Future<void> update(DiaryPostModel diary) async {}

  @override
  String status(String id) => '이 기기에 보관됨';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  await preferences.setBool('has_seen_welcome', true);
  await initializeDateFormatting('ko_KR');
  // A non-routable local client satisfies constructors in the existing stores.
  // All data providers are overridden; no production credentials are read.
  await Supabase.initialize(
    url: 'http://127.0.0.1:9',
    publishableKey: 'aso-local-fixture',
    debug: false,
  );
  final font = await rootBundle.load(
    'assets/fonts/Pretendard/Pretendard-SemiBold.ttf',
  );
  await (FontLoader('ASOHeadline')..addFont(Future.value(font))).load();
  _diaries = [
    _diary(
      0,
      '퇴근길 노을',
      '평소보다 조금 천천히 걸었다.\n강 위에 내려앉은 노을이 참 예뻤다.\n이런 작은 순간을 오래 기억하고 싶다.',
      '행복한감자',
    ),
    _diary(
      1,
      '친구와 먹은 저녁',
      '오랜만에 친구와 따뜻한 저녁을 먹었다.\n별것 아닌 이야기에도 한참 웃었다.',
      '설렌감자',
    ),
    _diary(2, '창가의 햇살', '좋아하는 음악을 들으며 잠깐 쉬었다.\n오늘은 마음에도 여유가 생긴 하루.', '행복한감자'),
    _diary(
      3,
      '비 온 뒤의 노을',
      '비가 그치고 하늘이 분홍빛으로 물들었다.\n창문을 열고 저녁 공기를 느꼈다.',
      '설렌감자',
    ),
    _diary(
      4,
      '조금 지친 하루',
      '바쁜 하루였지만 무사히 마쳤다.\n오늘도 애쓴 나에게 수고했다고 말해주고 싶다.',
      '답답한감자',
    ),
    _diary(
      5,
      '산책하다 만난 노을',
      '집으로 돌아가는 길, 하늘이 참 예뻤다.\n잠깐 멈춰 사진 한 장을 남겼다.',
      '행복한감자',
    ),
    _diary(6, '작은 선물', '나를 생각하며 골랐다는 말이 더 고마웠다.\n따뜻한 마음 덕분에 웃게 된 하루.', '설렌감자'),
  ];
  _drafts = [
    LocalDraft(
      _diary(
        10,
        '친구와 먹은 저녁',
        '오랜만에 만나서 더 반가웠던 저녁.\n따뜻한 음식 앞에서 나눈 이야기들을 적어보려 한다.',
        '설렌감자',
      ).copyWith(
        isDraft: true,
        updatedAt: _date.add(const Duration(hours: 10)),
      ),
    ),
    LocalDraft(
      _diary(
        11,
        '주말에 하고 싶은 일',
        '느지막이 일어나 커피를 내리고\n좋아하는 책을 읽으며 쉬고 싶다.',
        '행복한감자',
      ).copyWith(
        isDraft: true,
        updatedAt: _date.subtract(const Duration(days: 1)),
      ),
    ),
    LocalDraft(
      _diary(12, '오늘의 작은 발견', '매일 지나던 길에도 새로운 풍경이 있었다.', '행복한감자').copyWith(
        isDraft: true,
        updatedAt: _date.subtract(const Duration(days: 2)),
      ),
    ),
  ];
  // 42 completed entries explain EXP 42; a gap before the most recent week
  // keeps the current streak at seven days.
  _diaries.addAll([
    for (var index = 8; index < 43; index++)
      _diary(index, '소중한 하루', '오늘도 작은 행복 하나를 기억해두었다.', '행복한감자'),
  ]);
  _container = ProviderContainer(
    overrides: [
      profileProvider.overrideWith((ref) => _CaptureProfile()),
      diaryListProvider.overrideWith((ref) async => _diaries),
      paginatedDiaryProvider.overrideWith((ref) => _CaptureDiaries()),
      draftStoreProvider.overrideWith((ref) => _CaptureDrafts()),
      widgetUpdateProvider.overrideWith((ref) async {}),
    ],
  );
  // Keep the editor controller alive while the standalone capture router
  // transitions between fixture screens.
  _container.listen(quillControllerProvider, (previous, next) {});
  _router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) => BottomBar(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/diary',
            builder: (context, state) => const DiaryPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/emotion',
        builder: (context, state) => const WriteSelectingEmotion(),
      ),
      GoRoute(
        path: '/photo',
        builder: (context, state) =>
            DiaryView(id: _diaries.first.id!, initial: _diaries.first),
      ),
      GoRoute(
        path: '/plain',
        builder: (context, state) =>
            DiaryView(id: _diaries[1].id!, initial: _diaries[1]),
      ),
      GoRoute(
        path: '/drafts',
        builder: (context, state) => const DraftListPage(),
      ),
      GoRoute(
        path: '/editor',
        builder: (context, state) => WritePage(draftId: _drafts.first.diary.id),
      ),
    ],
  );
  runApp(
    UncontrolledProviderScope(
      container: _container,
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: customThemeData,
          locale: const Locale('ko', 'KR'),
          supportedLocales: const [Locale('ko', 'KR')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          routerConfig: _router,
        ),
      ),
    ),
  );
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8765);
  debugPrint('ASO capture ready on 127.0.0.1:8765');
  await for (final request in server) {
    try {
      await _handle(request);
    } catch (error, stack) {
      debugPrint('$error\n$stack');
      request.response.statusCode = 500;
      request.response.write(error.toString());
    } finally {
      await request.response.close();
    }
  }
}

Future<void> _handle(HttpRequest request) async {
  final parts = request.uri.pathSegments;
  if (parts.firstOrNull == 'scene') {
    final scene = parts[1];
    if (scene == 'emotion') {
      _container.read(diaryProvider.notifier).setEmotion('행복한감자');
    }
    _router.go('/$scene');
    await Future<void>.delayed(const Duration(milliseconds: 750));
    await WidgetsBinding.instance.endOfFrame;
    request.response.write('ready:$scene');
  } else if (parts.firstOrNull == 'photo') {
    final bytes = await request.fold<List<int>>([], (a, b) => a..addAll(b));
    final file = File('${Directory.systemTemp.path}/aso-sunset.png');
    await file.writeAsBytes(bytes);
    _diaries[0] = _diaries[0].copyWith(
      content: jsonEncode([
        {
          'insert': {'image': file.path},
        },
        {'insert': '\n'},
        {'insert': '평소보다 조금 천천히 걸었다.\n'},
        {
          'insert': '강 위에 내려앉은 노을',
          'attributes': {'color': '#826a56', 'bold': true},
        },
        {'insert': '이 참 예뻤다.\n'},
      ]),
    );
    request.response.write('photo ready');
  } else if (parts.firstOrNull == 'widget') {
    await HomeWidget.setAppGroupId(StreakService.appGroupId);
    await HomeWidget.saveWidgetData<String>('nickname', '몽실이');
    await HomeWidget.saveWidgetData<String>(
      'weekly_emotions',
      StreakService.getWeeklyEmotions(_diaries),
    );
    await HomeWidget.saveWidgetData<String>('data_date', _day(_date));
    await HomeWidget.saveWidgetData<String>('today_emotion', '행복한감자');
    await HomeWidget.saveWidgetData<bool>('logged_in', true);
    await HomeWidget.saveWidgetData<int>('streak_count', 7);
    await HomeWidget.saveWidgetData<int>('current_level', 3);
    await HomeWidget.saveWidgetData<int>('current_exp', 8);
    await HomeWidget.saveWidgetData<int>('next_level_exp', 23);
    await HomeWidget.updateWidget(
      iOSName: StreakService.iOSWidgetName,
      androidName: StreakService.androidWidgetName,
    );
    request.response.write('widget ready');
  } else if (parts.firstOrNull == 'pin-widget') {
    if (!Platform.isAndroid) {
      throw StateError('Pin the iOS widget from the system widget gallery.');
    }
    await HomeWidget.requestPinWidget(
      androidName: StreakService.androidWidgetName,
    );
    request.response.write('confirm the widget on the capture device');
  } else if (parts.firstOrNull == 'editor-shot') {
    final bytes = await request.fold<List<int>>([], (a, b) => a..addAll(b));
    final codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
    _editorScreenshot?.dispose();
    _editorScreenshot = (await codec.getNextFrame()).image;
    codec.dispose();
    request.response.write('editor ready');
  } else if (parts.firstOrNull == 'render') {
    final bytes = await request.fold<List<int>>([], (a, b) => a..addAll(b));
    final screen = bytes.isEmpty
        ? null
        : (await (await ui.instantiateImageCodec(
            Uint8List.fromList(bytes),
          )).getNextFrame()).image;
    final png = await _render(parts[1], parts[2], screen);
    request.response.headers.contentType = ContentType('image', 'png');
    request.response.add(png);
    screen?.dispose();
  } else {
    request.response.write('ASO local fixture renderer');
  }
}

const _cream = Color(0xFFFFF8EE);
const _ink = Color(0xFF49372B);
const _blue = Color(0xFF94CFE8);
final Map<String, ui.Image> _images = {};
Future<ui.Image> _asset(String name) async {
  if (_images.containsKey(name)) return _images[name]!;
  final bytes = await rootBundle.load('assets/images/character/$name.png');
  final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
  final image = (await codec.getNextFrame()).image;
  codec.dispose();
  return _images[name] = image;
}

void _text(
  Canvas canvas,
  String text,
  Offset position,
  double size, {
  Color color = _ink,
  double width = 1100,
  TextAlign align = TextAlign.left,
}) {
  final painter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(
        fontFamily: 'ASOHeadline',
        fontSize: size,
        color: color,
        height: 1.18,
        letterSpacing: -size * .035,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: align,
  )..layout(minWidth: align == TextAlign.center ? width : 0, maxWidth: width);
  painter.paint(canvas, position);
}

void _image(Canvas canvas, ui.Image image, Rect target) {
  final scale = (target.width / image.width).clamp(
    0.0,
    target.height / image.height,
  );
  final size = Size(image.width * scale, image.height * scale);
  final destination = Rect.fromCenter(
    center: target.center,
    width: size.width,
    height: size.height,
  );
  canvas.drawImageRect(
    image,
    Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
    destination,
    Paint()..filterQuality = FilterQuality.high,
  );
}

void _phone(Canvas canvas, ui.Image screen, Rect box, {bool ios = true}) {
  final radius = box.width * .105;
  final outer = RRect.fromRectAndRadius(
    box.inflate(15),
    Radius.circular(radius + 15),
  );
  canvas.drawRRect(
    outer.shift(const Offset(0, 28)),
    Paint()
      ..color = const Color(0x2349372B)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28),
  );
  canvas.drawRRect(outer, Paint()..color = const Color(0xFF655143));
  canvas.drawRRect(
    RRect.fromRectAndRadius(box.inflate(9), Radius.circular(radius + 9)),
    Paint()..color = const Color(0xFF201D1A),
  );
  canvas.save();
  canvas.clipRRect(RRect.fromRectAndRadius(box, Radius.circular(radius)));
  canvas.drawRect(box, Paint()..color = Colors.white);
  canvas.drawImageRect(
    screen,
    Rect.fromLTWH(0, 0, screen.width.toDouble(), screen.height.toDouble()),
    box,
    Paint()..filterQuality = FilterQuality.high,
  );
  canvas.restore();
}

Future<Uint8List> _render(
  String platform,
  String scene,
  ui.Image? screen,
) async {
  final feature = scene == 'feature';
  final ios = platform == 'ios';
  final width = feature ? 1024 : (ios ? 1320 : 1080);
  final height = feature ? 500 : (ios ? 2868 : 1920);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawColor(feature ? _blue : _cream, BlendMode.src);
  if (feature) {
    _text(
      canvas,
      '하루를 남기고, 감자를 키워요',
      const Offset(90, 64),
      48,
      width: 844,
      align: TextAlign.center,
    );
    for (var i = 0; i < 3; i++) {
      _image(
        canvas,
        await _asset('img-potato-${[1, 3, 7][i]}lv'),
        Rect.fromLTWH(140 + 250.0 * i, 185, 230, 215),
      );
    }
    _image(
      canvas,
      await _asset('cloud'),
      const Rect.fromLTWH(25, 170, 110, 90),
    );
    _image(
      canvas,
      await _asset('cloud'),
      const Rect.fromLTWH(865, 310, 110, 90),
    );
  } else {
    final w = width.toDouble();
    final h = height.toDouble();
    final s = w / 1320;
    // A quiet sky arc creates continuity while leaving the copy on cream.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * .75, h * .79),
        width: w * 1.65,
        height: h * .93,
      ),
      Paint()..color = _blue.withValues(alpha: .38),
    );
    _text(
      canvas,
      '감자일기',
      Offset(w * .085, h * .045),
      30 * s,
      color: const Color(0xFF92765F),
      width: w * .8,
    );
    final headlines = {
      'home': ['일기를 쓰면', '감자도 자라요'],
      'emotion': ['오늘의 기분을', '감자 표정으로'],
      'photo': ['사진 한 장에', '오늘 이야기를 더해요'],
      'widget': ['홈 화면에서도', '감자와 함께'],
      'diary': ['다시 보고 싶은 날을', '쉽게 찾아요'],
      'drafts': ['쓰다 만 이야기는', '이어서 써요'],
    }[scene]!;
    final fontSize = scene == 'photo' || scene == 'diary' ? 86 * s : 96 * s;
    _text(
      canvas,
      headlines[0],
      Offset(w * .085, h * .095),
      fontSize,
      width: w * .85,
    );
    _text(
      canvas,
      headlines[1],
      Offset(w * .085, h * .095 + fontSize * 1.23),
      fontSize,
      width: w * .85,
    );
    final phoneWidth = ios
        ? w * (scene == 'home' ? .68 : .72)
        : w * (scene == 'home' ? .55 : .58);
    final phoneHeight = phoneWidth * screen!.height / screen.width;
    final phoneY = scene == 'home' ? h * .29 : h * (ios ? .255 : .24);
    final phoneBox = Rect.fromLTWH(
      (w - phoneWidth) / 2,
      phoneY,
      phoneWidth,
      phoneHeight,
    );
    if (scene == 'drafts' && _editorScreenshot != null) {
      final listWidth = w * .57;
      _phone(
        canvas,
        screen,
        Rect.fromLTWH(
          w * .065,
          h * .27,
          listWidth,
          listWidth * screen.height / screen.width,
        ),
        ios: ios,
      );
      final editor = _editorScreenshot!;
      final editorWidth = w * (ios ? .53 : .44);
      _phone(
        canvas,
        editor,
        Rect.fromLTWH(
          w * (ios ? .42 : .50),
          h * (ios ? .44 : .42),
          editorWidth,
          editorWidth * editor.height / editor.width,
        ),
        ios: ios,
      );
    } else {
      _phone(canvas, screen, phoneBox, ios: ios);
    }
    if (scene == 'home') {
      for (var i = 0; i < 3; i++) {
        _image(
          canvas,
          await _asset('img-potato-${[1, 3, 7][i]}lv'),
          Rect.fromLTWH(w * (.25 + i * .17), h * .205, w * .14, h * .075),
        );
      }
    }
    if (scene == 'emotion') {
      _image(
        canvas,
        await _asset('img-potato-happy'),
        Rect.fromLTWH(w * .76, h * .66, w * .22, w * .22),
      );
      _image(
        canvas,
        await _asset('img-potato-excited'),
        Rect.fromLTWH(w * .025, h * .78, w * .21, w * .21),
      );
    }
    if (scene == 'photo') {
      _image(
        canvas,
        await _asset('sun'),
        Rect.fromLTWH(w * .79, h * .78, w * .17, w * .17),
      );
    }
    if (scene == 'diary') {
      _image(
        canvas,
        await _asset('img-potato-happy'),
        Rect.fromLTWH(w * .77, h * .78, w * .2, w * .2),
      );
    }
    _image(
      canvas,
      await _asset('cloud'),
      Rect.fromLTWH(w * .015, h * .91, w * .22, w * .16),
    );
    if (scene != 'home') {
      _image(
        canvas,
        await _asset('cloud'),
        Rect.fromLTWH(w * .82, h * .34, w * .21, w * .17),
      );
    }
  }
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  picture.dispose();
  return data!.buffer.asUint8List();
}
