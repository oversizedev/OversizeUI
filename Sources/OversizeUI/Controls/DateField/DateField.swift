//
// Copyright © 2023 Alexander Romanov
// DateField.swift, created on 26.02.2023
//

import SwiftUI

#if os(iOS)
@available(iOS 15.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct DateField: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldLabelPosition) private var fieldPlaceholderPosition: FieldLabelPosition
    @Binding private var selection: Date
    @Binding private var optionalSelection: Date?
    private let label: String
    @State private var showModal = false

    let isOptionalSelection: Bool

    public init(
        _ sheetTitle: String = "Date",
        selection: Binding<Date>
    ) {
        label = sheetTitle
        _selection = selection
        _optionalSelection = .constant(nil)
        isOptionalSelection = false
    }

    public init(
        _ label: String = "Date",
        selection: Binding<Date?>
    ) {
        self.label = label
        _selection = .constant(Date())
        _optionalSelection = selection
        isOptionalSelection = true
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            if fieldPlaceholderPosition == .adjacent {
                HStack {
                    Text(label)
                        .subheadline(.medium)
                        .foregroundColor(.onSurfaceHighEmphasis)
                    Spacer()
                }
            }
            Button {
                showModal.toggle()
            } label: {
                VStack(alignment: .leading, spacing: .xxxSmall) {
                    if fieldPlaceholderPosition == .overInput {
                        Text(label)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .onSurfaceDisabledForegroundColor()
                    }

                    HStack {
                        if isOptionalSelection, let optionalSelection {
                            Text(optionalSelection.formatted(date: .long, time: .shortened))
                        } else if isOptionalSelection {
                            Text(label)
                        } else {
                            Text(selection.formatted(date: .long, time: .shortened))
                        }
                        Spacer()
                        Image.Base.calendar
                    }
                }
            }
            .buttonStyle(.field)
        }
        .sheet(isPresented: $showModal) {
            if isOptionalSelection {
                DatePickerSheet(title: label, selection: $optionalSelection)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.hidden)
            } else {
                DatePickerSheet(title: label, selection: $selection)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
}
#endif
