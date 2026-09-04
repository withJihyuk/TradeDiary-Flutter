import WidgetKit
import SwiftUI

struct PotatoDiaryEntry: TimelineEntry {
    let date: Date
    let nickname: String
    let hasData: Bool
    let weeklyEmotions: [String: String]
}

struct PotatoDiaryProvider: TimelineProvider {
    let appGroupId = "group.com.example.tradeDiary"

    func placeholder(in context: Context) -> PotatoDiaryEntry {
        PotatoDiaryEntry(date: Date(), nickname: "감자", hasData: true, weeklyEmotions: [:])
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
        .supportedFamilies([.systemMedium])
    }
}

struct WidgetEntryView: View {
    let entry: PotatoDiaryEntry

    var body: some View {
        if !entry.hasData {
            LoggedOutView()
        } else {
            MediumWidgetView(entry: entry)
        }
    }
}
