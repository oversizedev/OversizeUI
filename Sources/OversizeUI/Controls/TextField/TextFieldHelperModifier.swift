//
// Copyright © 2023 Alexander Romanov
// TextFieldHelperModifier.swift
//

import SwiftUI

public enum TextFieldHelperStyle {
    case none
    case helperText
    case errorText
    case sussesText
}

public struct TextFieldHelperModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding public var helperText: String
    @Binding public var helperStyle: TextFieldHelperStyle
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
                        .subheadline(.semibold)
                        .foregroundColor(.onSurfaceMediumEmphasis)
                } else if helperStyle == .errorText {
                    Text(helperText)
                        .subheadline(.semibold)
                        .foregroundColor(.error)
                } else if helperStyle == .sussesText {
                    Text(helperText)
                        .subheadline(.semibold)
                        .foregroundColor(.success)
                }
            }
        }
    }
}

public extension View {
    func helper(_ text: Binding<String>, style: Binding<TextFieldHelperStyle>) -> some View {
        modifier(TextFieldHelperModifier(helperText: text, helperStyle: style))
    }
}
