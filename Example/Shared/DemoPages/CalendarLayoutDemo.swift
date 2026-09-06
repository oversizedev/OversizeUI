//
// Copyright © 2026 Alexander Romanov
// CalendarLayoutDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

#if os(iOS)
@available(iOS 18.0, *)
struct CalendarLayoutDemo: View {
    @State private var selection: Date = .init()

    private var interval: DateInterval {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .month, value: -6, to: .init()) ?? .init()
        let end = calendar.date(byAdding: .month, value: 6, to: .init()) ?? .init()
        return DateInterval(start: start, end: end)
    }

    var body: some View {
        CalendarLayout(interval: interval, selection: $selection) {
            Section("Selected day") {
                Row(selection.formatted(date: .complete, time: .omitted))
            }
        } day: { date in
            DefaultCalendarDayView(date: date, selection: $selection)
        }
    }
}

@available(iOS 18.0, *)
#Preview {
    NavigationStack {
        CalendarLayoutDemo()
    }
}
#endif
