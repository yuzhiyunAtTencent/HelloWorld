//
//  HelloWidget.swift
//  HelloWidget
//
//  Created by zhiyunyu on 2020/9/23.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), str: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), str: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minuteOffset in 0 ..< 60 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entryDate = Calendar.current.date(byAdding: .second, value: minuteOffset, to: currentDate)!
            
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm:ss"
            
            let entry = SimpleEntry(date: entryDate,
                                    str: dateformatter.string(from: entryDate))
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let str : String
}

struct HelloWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.str)
    }
}

@main
struct HelloWidget: Widget {
    let kind: String = "HelloWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HelloWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//struct HelloWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        HelloWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
