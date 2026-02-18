import WidgetKit
import SwiftUI

struct PotatoDiaryEntry: TimelineEntry {
    let date: Date
    let streakCount: Int
    let todayEmotion: String
    let currentLevel: Int
    let currentExp: Int
    let nextLevelExp: Int
    let nickname: String
    let hasData: Bool
    let weeklyEmotions: [String: String]
}

struct PotatoDiaryProvider: TimelineProvider {
    let appGroupId = "group.com.example.tradeDiary"

    func placeholder(in context: Context) -> PotatoDiaryEntry {
        PotatoDiaryEntry(date: Date(), streakCount: 5, todayEmotion: "행복한감자", currentLevel: 3, currentExp: 40, nextLevelExp: 57, nickname: "감자", hasData: true, weeklyEmotions: [:])
    }

    func getSnapshot(in context: Context, completion: @escaping (PotatoDiaryEntry) -> Void) {
        completion(readEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PotatoDiaryEntry>) -> Void) {
        let entry = readEntry()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func readEntry() -> PotatoDiaryEntry {
        let defaults = UserDefaults(suiteName: appGroupId)
        let nickname = defaults?.string(forKey: "nickname") ?? ""

        let weeklyJson = defaults?.string(forKey: "weekly_emotions") ?? "{}"
        let weeklyEmotions = (try? JSONSerialization.jsonObject(with: Data(weeklyJson.utf8))) as? [String: String] ?? [:]

        return PotatoDiaryEntry(
            date: Date(),
            streakCount: defaults?.integer(forKey: "streak_count") ?? 0,
            todayEmotion: defaults?.string(forKey: "today_emotion") ?? "",
            currentLevel: defaults?.integer(forKey: "current_level") ?? 1,
            currentExp: defaults?.integer(forKey: "current_exp") ?? 0,
            nextLevelExp: defaults?.integer(forKey: "next_level_exp") ?? 15,
            nickname: nickname,
            hasData: !nickname.isEmpty,
            weeklyEmotions: weeklyEmotions
        )
    }
}

struct LoggedOutView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("img_potato_1lv")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48, height: 48)
                .opacity(0.5)
            Text("로그인하고\n일기를 시작하세요")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(12)
        .widgetURL(URL(string: "potatoDiary://write"))
    }
}

struct SmallWidgetView: View {
    let entry: PotatoDiaryEntry

    var body: some View {
        VStack(spacing: 4) {
            Text(entry.streakCount > 0 ? "🔥 \(entry.streakCount)일 연속" : "오늘부터 시작!")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))

            Image("img_potato_\(min(max(entry.currentLevel, 1), 7))lv")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 56, height: 56)

            Text("LV.\(entry.currentLevel)")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(red: 0.51, green: 0.42, blue: 0.34))

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.78, green: 0.66, blue: 0.49))
                        .frame(width: geometry.size.width * progress, height: 6)
                }
            }
            .frame(height: 6)
            .padding(.horizontal, 8)
        }
        .padding(12)
        .widgetURL(URL(string: "potatoDiary://write"))
    }

    var progress: CGFloat {
        guard entry.nextLevelExp > 0 else { return 0 }
        return CGFloat(entry.currentExp) / CGFloat(entry.nextLevelExp)
    }
}

struct MediumWidgetView: View {
    let entry: PotatoDiaryEntry

    static let emotionImageMap: [String: String] = [
        "슬픈감자": "img_potato_sad",
        "부자감자": "img_potato_rich",
        "배고픈감자": "img_potato_hungry",
        "행복한감자": "img_potato_happy",
        "당황한감자": "img_potato_shocked",
        "화난감자": "img_potato_angry",
        "설렌감자": "img_potato_excited",
        "답답한감자": "img_potato_heavy",
    ]

    static let weekdayLabels = ["월", "화", "수", "목", "금", "토", "일"]

    private let globalMainColor = Color(red: 0.85, green: 0.66, blue: 0.50)

    var body: some View {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        // .weekday: 1=Sun, 2=Mon, ... 7=Sat → offset to Monday-based
        let mondayOffset = (weekday + 5) % 7
        let monday = calendar.date(byAdding: .day, value: -mondayOffset, to: today)!

        HStack(spacing: 0) {
            ForEach(0..<7, id: \.self) { i in
                let day = calendar.date(byAdding: .day, value: i, to: monday)!
                let dayNum = calendar.component(.day, from: day)
                let isToday = calendar.isDateInToday(day)
                let dateKey = Self.dateKey(from: day)
                let emotion = entry.weeklyEmotions[dateKey]
                let imageName = emotion.flatMap { Self.emotionImageMap[$0] }

                VStack(spacing: 4) {
                    Text(Self.weekdayLabels[i])
                        .font(.system(size: 10))
                        .foregroundColor(isToday ? globalMainColor : .gray)

                    if let imageName = imageName {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    } else {
                        ZStack {
                            if isToday {
                                Circle()
                                    .fill(globalMainColor)
                                    .frame(width: 32, height: 32)
                                Text("\(dayNum)")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                            } else {
                                Text("\(dayNum)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                                    .frame(width: 32, height: 32)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .widgetURL(URL(string: "potatoDiary://write"))
    }

    private static func dateKey(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

@main
struct PotatoDiaryWidget: Widget {
    let kind: String = "PotatoDiaryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PotatoDiaryProvider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WidgetEntryView(entry: entry)
                    .background(Color.white)
            }
        }
        .configurationDisplayName("감자일기")
        .description("감자의 성장과 일기 연속 기록을 확인하세요")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct WidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let entry: PotatoDiaryEntry

    var body: some View {
        if !entry.hasData {
            LoggedOutView()
        } else {
            switch family {
            case .systemMedium:
                MediumWidgetView(entry: entry)
            default:
                SmallWidgetView(entry: entry)
            }
        }
    }
}
