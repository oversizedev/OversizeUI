//
// Copyright © 2021 Alexander Romanov
// TextField.swift, created on 07.06.2020
//

import SwiftUI

// swiftlint:disable identifier_name
public struct LabeledTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldLabelPosition) private var fieldPlaceholderPosition: FieldLabelPosition
    @FocusState var isFocused: Bool
    @Binding private var text: String
    private let placeholder: String

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            if fieldPlaceholderPosition == .adjacent {
                HStack {
                    Text(placeholder)
                        .subheadline(.medium)
                        .foregroundColor(.onSurfaceHighEmphasis)
                    Spacer()
                }
            }
            ZStack(alignment: .leading) {
                labelTextView
                configuration
                    .headline(.medium)
                    .foregroundColor(.onSurfaceHighEmphasis)
                    .padding()
                    .padding(.vertical, .xxxSmall)
                    .offset(y: text.isEmpty ? 0 : 10)
                    .focused($isFocused)
            }
            .background(
                RoundedRectangle(cornerRadius: Radius.medium,
                                 style: .continuous)
                    .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
                    .overlay(overlay)
            )
        }
        .animation(.easeIn(duration: 0.15), value: text)
    }

    @ViewBuilder
    var overlay: some View {
        RoundedRectangle(cornerRadius: Radius.medium,
                         style: .continuous)
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
    }

    @ViewBuilder
    var labelTextView: some View {
        switch fieldPlaceholderPosition {
        case .default:
            if isFocused {
                Text(placeholder)
                    .subheadline()
                    .onSurfaceDisabledForegroundColor()
                    .opacity(0.7)
                    .padding(.small)
            }
        case .adjacent:
            EmptyView()
        case .overInput:
            Text(placeholder)
                .font(text.isEmpty ? .headline : .subheadline)
                .fontWeight(text.isEmpty ? .medium : .semibold)
                .onSurfaceDisabledForegroundColor()
                .padding(.small)
                .offset(y: text.isEmpty ? 0 : -13)
                .opacity(text.isEmpty ? 0 : 1)
        }
    }

    var overlayBorderColor: Color {
        if isFocused {
            return Color.accentColor
        } else if theme.borderTextFields {
            return Color.border
        } else {
            return Color.clear
        }
    }
}

public extension TextFieldStyle where Self == LabeledTextFieldStyle {
    static var `default`: LabeledTextFieldStyle {
        LabeledTextFieldStyle(placeholder: "", text: .constant(""))
    }

    static func placeholder(placeholder: String, text: Binding<String>) -> LabeledTextFieldStyle {
        LabeledTextFieldStyle(placeholder: placeholder, text: text)
    }
}

struct TextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(DefaultPlaceholderTextFieldStyle())

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(DefaultPlaceholderTextFieldStyle())
                .fieldHelper(.constant("Help"), style: .constant(.helperText))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))
                .fieldHelper(.constant("Ok"), style: .constant(.sussesText))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))
                .fieldHelper(.constant("Error"), style: .constant(.errorText))

        }.padding()
            .previewLayout(.sizeThatFits)
    }
}
