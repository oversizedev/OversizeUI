//
// Copyright © 2021 Alexander Romanov
// FieldHelperModifier.swift, created on 02.02.2023
//

import SwiftUI

public enum FieldHelperStyle {
    case none
    case helperText
    case errorText
    case sussesText
}

public struct FieldHelperViewModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding public var helperText: String
    @Binding public var helperStyle: FieldHelperStyle
    public init(helperText: Binding<String>, helperStyle: Binding<FieldHelperStyle>) {
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
    @available(*, deprecated, renamed: "fieldHelper")
    func helper(_ text: Binding<String>, style: Binding<FieldHelperStyle>) -> some View {
        modifier(FieldHelperViewModifier(helperText: text, helperStyle: style))
    }

    func fieldHelper(_ text: Binding<String>, style: Binding<FieldHelperStyle>) -> some View {
        modifier(FieldHelperViewModifier(helperText: text, helperStyle: style))
    }
}
