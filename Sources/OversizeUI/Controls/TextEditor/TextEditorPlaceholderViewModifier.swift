//
// Copyright © 2021 Alexander Romanov
// TextEditorPlaceholderViewModifier.swift, created on20.02.2023.
//

import SwiftUI

public struct TextEditorPlaceholderViewModifier: ViewModifier {
    private let placeholder: String
    @Binding private var text: String

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
    }

    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, .xSmall)
            .padding(.vertical, 10)
            .headline()
            .onSurfaceHighEmphasisForegroundColor()
            .background {
                RoundedRectangle(cornerRadius: .medium, style: .continuous)
                    .fillSurfaceSecondary()
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
}

public extension View {
    func textEditorPlaceholder(_ placeholder: String, text: Binding<String>) -> some View {
        modifier(TextEditorPlaceholderViewModifier(placeholder: placeholder, text: text))
    }
}
