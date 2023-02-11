//
// Copyright © 2021 Alexander Romanov
// TextField.swift, created on 07.06.2020
//

import SwiftUI

// swiftlint:disable identifier_name
public struct DefaultPlaceholderTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    public init() {}

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading) {
            configuration
                .headline()
                .foregroundColor(.onSurfaceHighEmphasis)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Radius.medium,
                             style: .continuous)
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium,
                                     style: .continuous)
                        .stroke(theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                )
        )
    }
}

// swiftlint:disable identifier_name
public struct OverPlaceholderTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings

    public let placeholder: String

    public init(placeholder: String) {
        self.placeholder = placeholder
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
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
        }
    }
}

// swiftlint:disable identifier_name
public struct InsidePlaceholderTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings

    public let placeholder: String

    public init(placeholder: String) {
        self.placeholder = placeholder
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
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium,
                                         style: .continuous)
                            .stroke(theme.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                    )
            )
        }
    }
}

public extension TextFieldStyle where Self == DefaultPlaceholderTextFieldStyle {
    static var `default`: DefaultPlaceholderTextFieldStyle {
        DefaultPlaceholderTextFieldStyle()
    }
}

public extension TextFieldStyle where Self == OverPlaceholderTextFieldStyle {
    static func placeholder(_ placeholder: String) -> OverPlaceholderTextFieldStyle {
        OverPlaceholderTextFieldStyle(placeholder: placeholder)
    }
}

public extension TextFieldStyle where Self == InsidePlaceholderTextFieldStyle {
    static func placeholderInside(_ placeholder: String) -> InsidePlaceholderTextFieldStyle {
        InsidePlaceholderTextFieldStyle(placeholder: placeholder)
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
                .helper(.constant("Help"), style: .constant(.helperText))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))
                .helper(.constant("Ok"), style: .constant(.sussesText))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))
                .helper(.constant("Error"), style: .constant(.errorText))

        }.padding()
            .previewLayout(.sizeThatFits)
    }
}
