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
    @Environment(\.platform) private var platform: Platform
    @Binding public var helperText: String
    @Binding public var helperStyle: FieldHelperStyle
    public init(helperText: Binding<String>, helperStyle: Binding<FieldHelperStyle>) {
        _helperText = helperText
        _helperStyle = helperStyle
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: platform == .mac ? .xxxSmall : .xSmall) {
            content
            if helperText.isEmpty == false, helperStyle != .none {
                Text(helperText)
                    .subheadline(.medium)
                    .foregroundColor(helperForegroundColor)
                    .offset(x: platform == .mac ? 4 : 0)
            }
        }
        .animation(.easeIn(duration: 0.15), value: helperStyle)
    }

    private var helperForegroundColor: Color {
        switch helperStyle {
        case .helperText:
            Color.onSurfaceMediumEmphasis
        case .errorText:
            Color.error
        case .sussesText:
            Color.success
        case .none:
            Color.clear
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
