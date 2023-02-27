//
// Copyright © 2021 Alexander Romanov
// TextEditorPlaceholderViewModifier.swift, created on20.02.2023.
//

import SwiftUI

public struct TextEditorPlaceholderViewModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Binding private var text: String
    private let placeholder: String
    private let isFocused: Bool

    public init(placeholder: String, text: Binding<String>, focused: Bool = false) {
        self.placeholder = placeholder
        isFocused = focused
        _text = text
    }

    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, .xSmall)
            .padding(.vertical, 10)
            .headline()
            .onSurfaceHighEmphasisForegroundColor()
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: .medium, style: .continuous)
                        .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
                    overlay
                }
                .overlay(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .headline()
                            .onSurfaceDisabledForegroundColor()
                            .opacity(0.7)
                            .padding(.small)
                    }
                }
            }
            .frame(minHeight: Space.xxxLarge.rawValue)
    }

    @ViewBuilder
    var overlay: some View {
        RoundedRectangle(cornerRadius: Radius.medium, style: .continuous)
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

public extension View {
    func textEditorPlaceholder(_ placeholder: String, text: Binding<String>, focused: Bool = false) -> some View {
        modifier(TextEditorPlaceholderViewModifier(placeholder: placeholder, text: text, focused: focused))
    }
}
