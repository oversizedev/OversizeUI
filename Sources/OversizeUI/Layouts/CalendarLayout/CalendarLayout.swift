//
// Copyright © 2026 Alexander Romanov
// CalendarLayout.swift, created on 30.08.2026
//

import Foundation
import SwiftUI

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct CalendarLayout<
    Content: View,
    Day: View,
    Background: View
>: View {
    @Environment(\.calendar) private var calendar

    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGFloat, _ headerVisibleRatio: CGFloat) -> Void

    private let interval: DateInterval
    private let onScroll: ScrollAction?
    private let day: (Date) -> Day
    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    @Binding private var selection: Date

    @State private var displayedMonth: Date
    @State private var months: [Date] = []
    @State private var days: [Date: [Date]] = [:]
    @State private var calendarHeight: CGFloat?
    @State private var headerHeight: CGFloat = 0
    @State private var isShowMonthPicker: Bool = false

    private var columns: [GridItem] {
        Array(repeating: GridItem(spacing: 0), count: 7)
    }

    private var weekdaySymbols: [String] {
        let symbols = calendar.veryShortWeekdaySymbols
        let firstWeekday = calendar.firstWeekday - 1
        return Array(symbols[firstWeekday...] + symbols[..<firstWeekday])
    }

    public var body: some View {
        SwiftUI.ScrollView {
            SwiftUI.LazyVStack(spacing: .xxSmall) {
                SwiftUI.Group(sections: content) { sections in
                    SwiftUI.ForEach(sections) { section in
                        LayoutSectionView(
                            section: section,
                            isFirst: section.id == sections.first?.id,
                            isLast: section.id == sections.last?.id,
                            isStacked: sections.isEmpty == false
                        )
                    }
                }
            }
            .padding(.horizontal, .xxSmall)
        }
        .onScrollGeometryChange(for: CGFloat.self) { proxy in
            proxy.contentOffset.y + proxy.contentInsets.top
        } action: { _, value in
            updateScrollOffset(value)
        }
        .safeAreaBarTop {
            calendarView
                .ifUnavailable26 {
                    $0.background(Color.surfacePrimary.ignoresSafeArea())
                }
        }
        .ifUnavailable26 {
            $0.toolbarBackground(.hidden, for: .navigationBar)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button {
                    isShowMonthPicker = true
                } label: {
                    HStack(spacing: 3) {
                        Text(displayedMonth.formatted(.dateTime.month(.wide)))
                            .foregroundStyle(Color.onSurfacePrimary)

                        Text(displayedMonth.formatted(.dateTime.year()))
                            .foregroundStyle(Color.onSurfaceTertiary)

                        Image.Base.chevronDown.icon(Color.onSurfaceSecondary, size: .small)
                    }
                    .body(.semibold)
                }
                .buttonStyle(.scale)
            }
        }
        .background(background.ignoresSafeArea())
        .background {
            Color.clear
                .ignoresSafeArea()
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.safeAreaInsets.top + 44
                } action: { height in
                    let isInitial = headerHeight == 0
                    headerHeight = height
                    if isInitial {
                        onScroll?(.zero, 1.0)
                    }
                }
        }
        .toolbarTitleDisplayMode(.inline)
        .sensoryFeedback(.selection, trigger: selection)
        .sheet(isPresented: $isShowMonthPicker) {
            NavigationStack {
                MonthYearPickerSheet(
                    selection: monthPickerSelection,
                    in: monthPickerRange
                )
            }
            .presentationDetents([.height(450)])
        }
    }

    private var monthPickerRange: ClosedRange<Date> {
        guard let first = months.first, let last = months.last, first <= last else {
            return interval.start ... interval.end
        }
        return first ... last
    }

    private var monthPickerSelection: Binding<Date> {
        Binding(
            get: { displayedMonth },
            set: { newValue in
                guard let normalized = calendar.date(
                    from: calendar.dateComponents([.year, .month], from: newValue)
                ) else { return }
                displayedMonth = months.contains(normalized)
                    ? normalized
                    : months.last(where: { $0 <= normalized }) ?? months.first ?? normalized
            }
        )
    }

    public var calendarView: some View {
        VStack(spacing: .zero) {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(Array(weekdaySymbols.enumerated()), id: \.offset) { _, symbol in
                    Text(symbol)
                        .footnote(.semibold)
                        .foregroundColor(.onSurfaceSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, .xSmall)
                }
            }
            .padding(.horizontal, .xxSmall)

            Separator()
                .padding(.vertical, .xxxSmall)

            TabView(selection: $displayedMonth) {
                ForEach(months, id: \.self) { month in
                    LazyVGrid(columns: columns) {
                        Section {
                            ForEach(days[month, default: []], id: \.self) { date in
                                if calendar.isDate(date, equalTo: month, toGranularity: .month), interval.contains(date) {
                                    Button {
                                        selection = date
                                    } label: {
                                        day(date)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                    .buttonStyle(.scale)
                                } else if calendar.isDate(date, equalTo: month, toGranularity: .month), !interval.contains(date) {
                                    Button {
                                        selection = date
                                    } label: {
                                        day(date)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .opacity(0.3)
                                    }
                                    .disabled(true)
                                } else {
                                    Button {
                                        selection = date
                                    } label: {
                                        day(date)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                    .buttonStyle(.scale)
                                    .disabled(true)
                                    .opacity(0)
                                }
                            }
                        }
                        .animation(.interactiveSpring, value: selection)
                    }
                    .padding(.horizontal, .xxSmall)
                    .padding(.vertical, .xxxSmall)
                    .readSize { size in
                        MainActor.assumeIsolated {
                            calendarHeight = max(calendarHeight ?? 0, size.height)
                        }
                    }
                    .tag(month)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .frame(height: calendarHeight)
            .onAppear { prepareCalendar() }
            .onChange(of: selection) { _, newValue in
                let newMonth = calendar.date(
                    from: calendar.dateComponents([.year, .month], from: newValue)
                ) ?? newValue
                if !calendar.isDate(displayedMonth, equalTo: newMonth, toGranularity: .month) {
                    displayedMonth = newMonth
                }
            }
        }
    }

    private func prepareCalendar() {
        func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
            var dates: [Date] = []
            dates.append(interval.start)

            calendar.enumerateDates(
                startingAfter: interval.start,
                matching: components,
                matchingPolicy: .nextTime
            ) { date, _, stop in
                if let date {
                    if date < interval.end {
                        dates.append(date)
                    } else {
                        stop = true
                    }
                }
            }

            return dates
        }

        months = generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
        .compactMap { date in
            calendar.date(from: calendar.dateComponents([.year, .month], from: date))
        }
        .reduce(into: [Date]()) { result, month in
            if result.last != month {
                result.append(month)
            }
        }

        days = months.reduce(into: [:]) { current, month in
            guard
                let monthInterval = calendar.dateInterval(of: .month, for: month),
                let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end),
                let weekAfterMonthEnd = calendar.date(byAdding: .weekOfYear, value: 1, to: monthInterval.end),
                let nextMonthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: weekAfterMonthEnd)
            else { return }

            let numberOfDays = calendar.dateComponents(
                [.day],
                from: calendar.startOfDay(for: monthFirstWeek.start),
                to: calendar.startOfDay(for: monthLastWeek.end)
            ).day ?? 0

            current[month] = generateDates(
                inside: DateInterval(
                    start: monthFirstWeek.start,
                    end: numberOfDays < 42 ? nextMonthFirstWeek.end : monthLastWeek.end
                ),
                matching: DateComponents(hour: 0, minute: 0, second: 0)
            )
        }
    }

    private func updateScrollOffset(_ offset: CGFloat) {
        guard headerHeight > 0 else { return }
        let visibleRatio: CGFloat = (headerHeight - offset) / headerHeight
        onScroll?(offset, visibleRatio)
    }

    public init(
        interval: DateInterval,
        selection: Binding<Date>,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder day: @escaping (Date) -> Day,
        @ViewBuilder background: () -> Background = { Color.backgroundSecondary }
    ) {
        self.interval = interval
        _selection = selection
        let initialMonth = Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month], from: selection.wrappedValue)
        ) ?? selection.wrappedValue
        _displayedMonth = State(initialValue: initialMonth)
        self.content = content()
        self.day = day
        self.onScroll = onScroll
        self.background = background()
    }
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public extension CalendarLayout where Day == DefaultCalendarDayView {
    init(
        interval: DateInterval,
        selection: Binding<Date>,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundSecondary }
    ) {
        self.init(
            interval: interval,
            selection: selection,
            onScroll: onScroll,
            content: content,
            day: { date in
                DefaultCalendarDayView(date: date, selection: selection)
            },
            background: background
        )
    }
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
#Preview("Default Day View") {
    @Previewable @State var selection = Date()

    NavigationStack {
        CalendarLayout(
            interval: DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
                end: Calendar.current.date(byAdding: .month, value: 6, to: Date()) ?? Date()
            ),
            selection: $selection,
            content: {
                Section("Selected") {
                    Row(selection.formatted(.dateTime.day().month().year()))
                }

                Section("Events") {
                    Row("Morning run")
                    Row("Design review")
                    Row("Dinner")
                }
            }
        )
        .sectionTitlePosition(.inside)
        .bordered()
        .sectionTitleSeparator(.visible)
    }
}

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
#Preview("Custom Day View") {
    @Previewable @State var selection = Date()

    NavigationStack {
        CalendarLayout(
            interval: DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
                end: Calendar.current.date(byAdding: .month, value: 6, to: Date()) ?? Date()
            ),
            selection: $selection,
            content: {
                Section {
                    Row("Select: \(selection.formatted(.dateTime.day().month().year()))")
                }
            },
            day: { date in
                Text(date.formatted(.dateTime.day()))
                    .padding(.vertical, .xxSmall)
            },
            background: { Color.backgroundSecondary }
        )
    }
}
