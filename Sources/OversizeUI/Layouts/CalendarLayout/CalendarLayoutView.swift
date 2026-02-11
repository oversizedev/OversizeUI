//
// Copyright © 2025 Alexander Romanov
// CalendarLayoutView.swift, created on 06.01.2025
//

import SwiftUI
import Foundation

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct CalendarLayoutView<
    Content: View,
    Day: View,
    Background: View
>: View {
    
    @Environment(\.sizeCategory) private var contentSize
    @Environment(\.calendar) private var calendar
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @ViewBuilder private let background: Background
    private let interval: DateInterval
    private let content: () -> Content
    private let day: (Date) -> Day

    private let onScroll: ScrollAction?

    @Binding var selection: Date
    @State private var displayedMonth: Date
    @State private var months: [Date] = []
    @State private var days: [Date: [Date]] = [:]
    @State private var calendarHeight: CGFloat?
    
    @State private var isShowMonthPicker: Bool = false

    private var columns: [GridItem] {
        return Array(repeating: GridItem(spacing: 0), count: 7)
    }

    private var weekdaySymbols: [String] {
        let symbols = calendar.veryShortWeekdaySymbols
        let firstWeekday = calendar.firstWeekday - 1
        return Array(symbols[firstWeekday...] + symbols[..<firstWeekday])
    }

    public var body: some View {
        ScrollView {
            ScrollViewOffsetTracker {
                content()
            }
        }
        .scrollViewOffsetTracking(action: handleScrollOffset)
        .safeAreaBarTop {
            calendarView
                .ifUnavailable26 {
                    $0.background(Color.surfacePrimary.ignoresSafeArea())
                }
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
        .toolbarTitleDisplayMode(.inline)
        .sensoryFeedback(.selection, trigger: selection)
        .sheet(isPresented: $isShowMonthPicker) {
            NavigationStack {
                MonthYearPickerSheet(
                    selection: $displayedMonth,
                    in: interval.start...interval.end
                )
            }
            .presentationDetents([.height(450)])
        }
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
     
    private func handleScrollOffset(_ offset: CGPoint) {
        let calcHeaderHeight = 44 + safeAreaInsets.top
        let visibleRatio: CGFloat = (calcHeaderHeight + offset.y) / calcHeaderHeight
        onScroll?(offset, visibleRatio)
    }
    
    public init(
        interval: DateInterval,
        selection: Binding<Date>,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder day: @escaping (Date) -> Day,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) {
        self.interval = interval
        _selection = selection
        let initialMonth = Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month], from: selection.wrappedValue)
        ) ?? selection.wrappedValue
        _displayedMonth = State(initialValue: initialMonth)
        self.content = content
        self.day = day
        self.onScroll = onScroll
        self.background = background()
    }
}

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension CalendarLayoutView where Day == DefaultCalendarDayView {
    public init(
        interval: DateInterval,
        selection: Binding<Date>,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
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

@available(iOS 17.0, *)
public struct DefaultCalendarDayView: View {
    let date: Date
    @Binding var selection: Date
    @Environment(\.calendar) private var calendar

    public init(date: Date, selection: Binding<Date>) {
        self.date = date
        _selection = selection
    }

    public var body: some View {
        Text(date.formatted(.dateTime.day()))
            .callout(.semibold)
            .foregroundColor(foregroundColor)
            .background {
                Circle()
                    .fill(selectionCircleFillColor)
                    .frame(width: 40, height: 40)
            }
            .padding(.vertical, .xxSmall)
            .contentShape(Rectangle())
    }

    private var isSelected: Bool {
        calendar.isDate(date, inSameDayAs: selection)
    }

    private var isToday: Bool {
        calendar.isDate(date, inSameDayAs: Date())
    }

    private var foregroundColor: Color {
        if isSelected {
            return .onPrimary
        } else if isToday {
            return .onSurfaceSecondary
        } else {
            return .onSurfacePrimary
        }
    }

    private var selectionCircleFillColor: Color {
        if isSelected {
            return .accent
        } else if isToday {
            return .surfaceTertiary
        } else {
            return .clear
        }
    }
}

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
#Preview("Custom Day View") {
    @Previewable @State var selection = Date()

    return NavigationStack {
        CalendarLayoutView(
            interval: DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
                end: Calendar.current.date(byAdding: .month, value: 6, to: Date()) ?? Date()
            ),
            selection: $selection,
            content: {
                VStack {
                    Text("Select: \(selection.formatted(.dateTime))")
                        .frame(maxWidth: .infinity, minHeight: 44)
                    Spacer()
                }
                .background {
                    Color.surfaceTertiary
                }
            },
            day: { date in
                Text(date.formatted(.dateTime.day()))
            },
            background: { Color.backgroundSecondary }
        )
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
#Preview("Default Day View") {
    @Previewable @State var selection = Date()

    return NavigationStack {
        CalendarLayoutView(
            interval: DateInterval(
                start: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
                end: Calendar.current.date(byAdding: .month, value: 6, to: Date()) ?? Date()
            ),
            selection: $selection,
            content: {
                VStack {
                    VStack {
                        Text("Select:")
                            .headline()
                        Text(selection.formatted(.dateTime.day().month().year()))
                            .title()
                    }
                    .frame(maxWidth: .infinity, minHeight: 100)
                    Spacer()
                }
                .background(Color.surfaceTertiary)
            },
            background: { Color.backgroundSecondary }
        )
        .toolbarTitleDisplayMode(.inline)
    }
}
