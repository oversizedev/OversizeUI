//
// Copyright © 2026 Alexander Romanov
// MonthYearPickerSheet.swift, created on 11.02.2026
//

import SwiftUI

@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct MonthYearPickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.calendar) private var calendar
    @Binding var selection: Date

    @State private var selectedMonth: Int
    @State private var selectedYear: Int?

    private let title: String
    private let years: [Int]
    private let dateRange: ClosedRange<Date>

    private var availableMonths: [Int] {
        guard let year = selectedYear else { return Array(1 ... 12) }

        let startYear = calendar.component(.year, from: dateRange.lowerBound)
        let endYear = calendar.component(.year, from: dateRange.upperBound)

        if year == startYear, year == endYear {
            let startMonth = calendar.component(.month, from: dateRange.lowerBound)
            let endMonth = calendar.component(.month, from: dateRange.upperBound)
            return Array(startMonth ... endMonth)
        } else if year == startYear {
            let startMonth = calendar.component(.month, from: dateRange.lowerBound)
            return Array(startMonth ... 12)
        } else if year == endYear {
            let endMonth = calendar.component(.month, from: dateRange.upperBound)
            return Array(1 ... endMonth)
        } else {
            return Array(1 ... 12)
        }
    }

    public init(
        _ title: String = "Select Date",
        selection: Binding<Date>,
        in range: ClosedRange<Date>? = nil
    ) {
        self.title = title
        _selection = selection

        let defaultStartDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 1)) ?? Date()
        let defaultEndDate = Calendar.current.date(from: DateComponents(year: 2100, month: 12, day: 31)) ?? Date()
        dateRange = range ?? (defaultStartDate ... defaultEndDate)

        let currentDate: Date = if selection.wrappedValue < dateRange.lowerBound {
            dateRange.lowerBound
        } else if selection.wrappedValue > dateRange.upperBound {
            dateRange.upperBound
        } else {
            selection.wrappedValue
        }

        let components = Calendar.current.dateComponents([.month, .year], from: currentDate)
        _selectedMonth = State(initialValue: components.month ?? 1)
        _selectedYear = State(initialValue: components.year ?? Calendar.current.component(.year, from: Date()))

        let startYear = Calendar.current.component(.year, from: dateRange.lowerBound)
        let endYear = Calendar.current.component(.year, from: dateRange.upperBound)
        years = Array(startYear ... endYear)
    }

    public var body: some View {
        VStack(spacing: .zero) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(years, id: \.self) { year in
                        Text(String(year))
                            .containerRelativeFrame(.horizontal, count: 3, spacing: 0)
                            .foregroundStyle(selectedYear == year ? Color.accent : Color.onSurfaceSecondary)
                            .headline(selectedYear == year ? .bold : .semibold)
                            .padding(.vertical, .xxSmall)
                            .overlay(alignment: .bottom) {
                                Circle()
                                    .fill(selectedYear == year ? Color.accent : Color.clear)
                                    .frame(width: 6, height: 6, alignment: .center)
                            }
                            .onTapGesture(perform: {
                                selectedYear = year
                            })
                            .id(year)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $selectedYear, anchor: .center)
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 60)
            .scrollIndicators(.hidden)
            .mask {
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .clear, location: 0),
                        .init(color: .black, location: 0.12),
                        .init(color: .black, location: 0.88),
                        .init(color: .clear, location: 1.0),
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            }
            .animation(.interactiveSpring, value: selectedYear)
            .sensoryFeedback(.selection, trigger: selectedYear)

            Separator()

            Picker("Month", selection: $selectedMonth) {
                ForEach(availableMonths, id: \.self) { month in
                    Text(monthName(month))
                        .tag(month)
                }
            }
            .pickerStyle(.wheel)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .paddingContent()
            .onChange(of: selectedYear) { _, _ in
                if !availableMonths.contains(selectedMonth) {
                    selectedMonth = availableMonths.first ?? 1
                }
            }
        }
        .background(ContainerRelativeShape().fill(Color.surfacePrimary))
        .padding(10)
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(
                    "Close",
                    systemImage: "xmark",
                    role: .cancel,
                    action: {
                        dismiss()
                    }
                )
                .labelStyle(.toolbar)
                .buttonStyle(.toolbarSecondary)
                #if !os(tvOS)
                    .keyboardShortcut(.cancelAction)
                #endif
            }

            ToolbarItem(placement: .primaryAction) {
                Button(
                    "Done",
                    systemImage: "checkmark",
                    action: {
                        updateSelection()
                        dismiss()
                    }
                )
                .labelStyle(.toolbar)
                .buttonStyle(.toolbarPrimary)
                #if !os(tvOS)
                    .keyboardShortcut(.defaultAction)
                #endif
            }
        }
    }

    private func monthName(_ month: Int) -> String {
        let dateComponents = DateComponents(year: 2000, month: month)
        guard let date = calendar.date(from: dateComponents) else { return "" }
        return date.formatted(.dateTime.month(.wide))
    }

    private func updateSelection() {
        let components = DateComponents(year: selectedYear, month: selectedMonth, day: 1)
        if let newDate = calendar.date(from: components) {
            if newDate < dateRange.lowerBound {
                selection = dateRange.lowerBound
            } else if newDate > dateRange.upperBound {
                selection = dateRange.upperBound
            } else {
                selection = newDate
            }
        }
    }
}
