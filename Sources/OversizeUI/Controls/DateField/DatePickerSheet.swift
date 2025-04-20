//
// Copyright © 2021 Alexander Romanov
// DatePickerSheet.swift, created on 11.12.2022
//

import SwiftUI

#if os(iOS)
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

        public init(title: String, selection: Binding<Date>) {
            self.title = title
            _selection = selection
            _date = State(wrappedValue: selection.wrappedValue)
            _optionalSelection = .constant(nil)
        }

        public init(title: String, selection: Binding<Date?>) {
            self.title = title
            _date = State(wrappedValue: selection.wrappedValue ?? Date())
            _optionalSelection = selection
            _selection = .constant(Date())
        }

        public var body: some View {
            PageView(title) {
                SectionView {
                    VStack {
                        if let minimumDate {
                            DatePicker("", selection: $date, in: minimumDate...)
                                .datePickerStyle(.graphical)
                                .labelsHidden()
                        } else {
                            DatePicker("", selection: $date)
                                .datePickerStyle(.graphical)
                                .labelsHidden()
                        }
                    }
                    .padding(.horizontal, .small)
                    .padding(.vertical, .xxxSmall)
                }
                .surfaceContentMargins(.zero)
            }
            .backgroundSecondary()
            .leadingBar {
                BarButton(.close)
            }
            .trailingBar {
                BarButton(.accent("Done", action: {
                    selection = date
                    optionalSelection = date
                    dismiss()
                }))
            }
        }

        public func datePickerMinimumDate(_ date: Date) -> DatePickerSheet {
            var control = self
            control.minimumDate = date
            return control
        }
    }
#endif
