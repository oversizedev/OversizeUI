//
// Copyright © 2021 Alexander Romanov
// TextField.swift, created on 07.06.2020
//

import SwiftUI

// swiftlint:disable identifier_name
public struct DefaultPlaceholderTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings

    private let isFocused: Bool

    public init(focused: Bool = false) {
        isFocused = focused
    }

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading) {
            configuration
                .headline()
                .foregroundColor(.onSurfaceHighEmphasis)
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: Radius.medium,
                style: .continuous
            )
            .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
            .overlay(overlay)
        )
    }

    @ViewBuilder
    var overlay: some View {
        RoundedRectangle(cornerRadius: Radius.medium,
                         style: .continuous)
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
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

// swiftlint:disable identifier_name
public struct OverPlaceholderTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings

    public let placeholder: String
    private let isFocused: Bool

    public init(placeholder: String, focused: Bool = false) {
        self.placeholder = placeholder
        isFocused = focused
    }

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(placeholder)
                    .subheadline(.semibold)
                    .foregroundColor(.onSurfaceHighEmphasis)
                Spacer()
            }

            VStack(alignment: .leading) {
                configuration
                    .headline()
                    .foregroundColor(.onSurfaceHighEmphasis)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium,
                                 style: .continuous)
                    .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
                    .overlay(overlay)
            )
        }
    }

    @ViewBuilder
    var overlay: some View {
        RoundedRectangle(cornerRadius: Radius.medium,
                         style: .continuous)
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
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

// swiftlint:disable identifier_name
public struct InsidePlaceholderTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings

    public let placeholder: String
    private let isFocused: Bool

    public init(placeholder: String, focused: Bool = false) {
        self.placeholder = placeholder
        isFocused = focused
    }

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(alignment: .leading) {
                HStack {
                    Text(placeholder)
                        .subheadline(.semibold)
                        .foregroundColor(.onSurfaceHighEmphasis)
                    Spacer()
                }

                configuration
                    .headline()
                    .foregroundColor(.onSurfaceHighEmphasis)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium,
                                 style: .continuous)
                    .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
                    .overlay(overlay)
            )
        }
    }

    @ViewBuilder
    var overlay: some View {
        RoundedRectangle(cornerRadius: Radius.medium,
                         style: .continuous)
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
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

public extension TextFieldStyle where Self == DefaultPlaceholderTextFieldStyle {
    static var `default`: DefaultPlaceholderTextFieldStyle {
        DefaultPlaceholderTextFieldStyle()
    }

    static func `default`(focused: Bool) -> DefaultPlaceholderTextFieldStyle {
        DefaultPlaceholderTextFieldStyle(focused: focused)
    }
}

public extension TextFieldStyle where Self == OverPlaceholderTextFieldStyle {
    static func placeholder(_ placeholder: String, focused: Bool = false) -> OverPlaceholderTextFieldStyle {
        OverPlaceholderTextFieldStyle(placeholder: placeholder, focused: focused)
    }
}

public extension TextFieldStyle where Self == InsidePlaceholderTextFieldStyle {
    static func placeholderInside(_ placeholder: String, focused: Bool = false) -> InsidePlaceholderTextFieldStyle {
        InsidePlaceholderTextFieldStyle(placeholder: placeholder, focused: focused)
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
