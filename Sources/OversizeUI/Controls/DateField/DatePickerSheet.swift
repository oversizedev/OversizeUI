//
// Copyright © 2021 Alexander Romanov
// DatePickerSheet.swift, created on 11.12.2022
//

import SwiftUI

#if os(iOS)
@available(iOS 17.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct DatePickerSheet: View {
    @Environment(\.screenSize) var screenSize
    @Environment(\.dismiss) var dismiss

    @Binding private var selection: Date
    @Binding private var optionalSelection: Date?
    @State private var date: Date

    private let title: String
    private var minimumDate: Date?
    private let displayedComponents: DatePicker.Components

    public init(title: String, selection: Binding<Date>, displayedComponents: DatePicker.Components = [.hourAndMinute, .date]) {
        self.title = title
        self.displayedComponents = displayedComponents
        _selection = selection
        _date = State(wrappedValue: selection.wrappedValue)
        _optionalSelection = .constant(nil)
    }

    public init(title: String, selection: Binding<Date?>, displayedComponents: DatePicker.Components = [.hourAndMinute, .date]) {
        self.title = title
        self.displayedComponents = displayedComponents
        _date = State(wrappedValue: selection.wrappedValue ?? Date())
        _optionalSelection = selection
        _selection = .constant(Date())
    }

    public var body: some View {
        LayoutView(title) {
            SectionView {
                VStack {
                    if let minimumDate {
                        DatePicker("", selection: $date, in: minimumDate..., displayedComponents: displayedComponents)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    } else {
                        DatePicker("", selection: $date, displayedComponents: displayedComponents)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                    }
                }
                .padding(.horizontal, .small)
                .padding(.vertical, .xxxSmall)
            }
            .surfaceContentMargins(.zero)
        } background: {
            Color.backgroundSecondary
        }
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
                        selection = date
                        optionalSelection = date
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
        .toolbarTitleDisplayMode(.inline)
    }

    public func datePickerMinimumDate(_ date: Date) -> DatePickerSheet {
        var control = self
        control.minimumDate = date
        return control
    }
}
#endif
