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
}

struct PotatoDiaryProvider: TimelineProvider {
    let appGroupId = "group.com.example.tradeDiary"

    func placeholder(in context: Context) -> PotatoDiaryEntry {
        PotatoDiaryEntry(date: Date(), streakCount: 5, todayEmotion: "행복한감자", currentLevel: 3, currentExp: 40, nextLevelExp: 57, nickname: "감자")
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
        return PotatoDiaryEntry(
            date: Date(),
            streakCount: defaults?.integer(forKey: "streak_count") ?? 0,
            todayEmotion: defaults?.string(forKey: "today_emotion") ?? "",
            currentLevel: defaults?.integer(forKey: "current_level") ?? 1,
            currentExp: defaults?.integer(forKey: "current_exp") ?? 0,
            nextLevelExp: defaults?.integer(forKey: "next_level_exp") ?? 15,
            nickname: defaults?.string(forKey: "nickname") ?? ""
        )
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

    var body: some View {
        HStack(spacing: 12) {
            Image("img_potato_\(min(max(entry.currentLevel, 1), 7))lv")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 72, height: 72)

            VStack(alignment: .leading, spacing: 3) {
                Text(entry.streakCount > 0 ? "🔥 \(entry.streakCount)일 연속" : "오늘부터 시작!")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))

                Text("LV.\(entry.currentLevel) \(entry.nickname)")
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.51, green: 0.42, blue: 0.34))

                Text(entry.todayEmotion.isEmpty ? "오늘 일기를 써봐요!" : "오늘: \(entry.todayEmotion)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

                HStack(spacing: 8) {
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

                    Text("\(entry.currentExp)/\(entry.nextLevelExp)")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                        .fixedSize()
                }
            }
        }
        .padding(12)
        .widgetURL(URL(string: "potatoDiary://write"))
    }

    var progress: CGFloat {
        guard entry.nextLevelExp > 0 else { return 0 }
        return CGFloat(entry.currentExp) / CGFloat(entry.nextLevelExp)
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
        switch family {
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}
