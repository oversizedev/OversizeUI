//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum TextFieldHelperStyle {
    case none
    case helperText
    case errorText
    case sussesText
}

// swiftlint:disable identifier_name
public struct DefaultPlaceholderTextFieldStyle: TextFieldStyle {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared
    public init() {}

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading) {
            configuration
                .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                             style: .continuous)
                .fill(Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                     style: .continuous)
                        .stroke(appearanceSettings.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                )
        )
    }
}

// swiftlint:disable identifier_name
public struct OverPlaceholderTextFieldStyle: TextFieldStyle {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    public let placeholder: String

    public init(placeholder: String) {
        self.placeholder = placeholder
    }

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(placeholder)
                    .fontStyle(.subtitle2, color: .onSurfaceHighEmphasis)
                Spacer()
            }

            VStack(alignment: .leading) {
                configuration
                    .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                         style: .continuous)
                            .stroke(appearanceSettings.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                    )
            )
        }
    }
}

// swiftlint:disable identifier_name
public struct InsidePlaceholderTextFieldStyle: TextFieldStyle {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    public let placeholder: String

    public init(placeholder: String) {
        self.placeholder = placeholder
    }

    public func _body(configuration: TextField<_Label>) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            VStack(alignment: .leading) {
                HStack {
                    Text(placeholder)
                        .fontStyle(.subtitle2, color: .onSurfaceHighEmphasis)
                    Spacer()
                }

                configuration
                    .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                 style: .continuous)
                    .fill(Color.surfaceSecondary)
                    .overlay(
                        RoundedRectangle(cornerRadius: Radius.medium.rawValue,
                                         style: .continuous)
                            .stroke(appearanceSettings.borderTextFields
                                ? Color.border
                                : Color.surfaceSecondary, lineWidth: CGFloat(appearanceSettings.borderSize))
                    )
            )
        }
    }
}

public struct TextFieldModifier: ViewModifier {
    @Binding public var helperText: String
    @Binding public var helperStyle: TextFieldHelperStyle
    @ObservedObject var appearanceSettings = AppearanceSettings.shared
    public init(helperText: Binding<String>, helperStyle: Binding<TextFieldHelperStyle>) {
        _helperText = helperText
        _helperStyle = helperStyle
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            if helperText != "" {
                if helperStyle == .helperText {
                    Text(helperText)
                        .fontStyle(.subtitle2, color: .onSurfaceMediumEmphasis)
                } else if helperStyle == .errorText {
                    Text(helperText)
                        .fontStyle(.subtitle2, color: .error)
                } else if helperStyle == .sussesText {
                    Text(helperText)
                        .fontStyle(.subtitle2, color: .success)
                }
            }
        }
    }
}

public extension View {
    func helper(_ text: Binding<String>, style: Binding<TextFieldHelperStyle>) -> some View {
        modifier(TextFieldModifier(helperText: text, helperStyle: style))
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
