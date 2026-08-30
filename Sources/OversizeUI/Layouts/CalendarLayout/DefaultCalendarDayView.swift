//
// Copyright © 2026 Alexander Romanov
// DefaultCalendarDayView.swift, created on 30.08.2026
//

import SwiftUI

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
            .onPrimary
        } else if isToday {
            .onSurfaceSecondary
        } else {
            .onSurfacePrimary
        }
    }

    private var selectionCircleFillColor: Color {
        if isSelected {
            .accent
        } else if isToday {
            .surfaceTertiary
        } else {
            .clear
        }
    }
}
