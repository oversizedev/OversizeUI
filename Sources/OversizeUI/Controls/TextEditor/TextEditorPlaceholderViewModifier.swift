//
// Copyright © 2021 Alexander Romanov
// TextEditorPlaceholderViewModifier.swift, created on20.02.2023.
//

import SwiftUI

public struct TextEditorPlaceholderViewModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldLabelPosition) private var fieldPlaceholderPosition: FieldLabelPosition
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
            .padding(.top, topInputPadding)
            .padding(.bottom, 10)
            .headline()
            .onSurfaceHighEmphasisForegroundColor()
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: .medium, style: .continuous)
                        .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
                    overlay
                }
                .overlay(alignment: .topLeading) {
                    labelTextView
                }
            }
            .frame(minHeight: Space.xxxLarge.rawValue)
            .animation(.easeIn(duration: 0.15), value: text)
    }

    var topInputPadding: CGFloat {
        switch fieldPlaceholderPosition {
        case .default, .adjacent:
            return 10
        case .overInput:
            return text.isEmpty ? 8 : 14
        }
    }

    @ViewBuilder
    var labelTextView: some View {
        switch fieldPlaceholderPosition {
        case .default:
            if text.isEmpty {
                Text(placeholder)
                    .font(.headline)
                    .onSurfaceDisabledForegroundColor()
                    .opacity(0.7)
                    .padding(.small)
            }
        case .adjacent:
            EmptyView()
        case .overInput:
            Text(placeholder)
                .font(text.isEmpty ? .headline : .caption)
                .onSurfaceDisabledForegroundColor()
                .opacity(0.7)
                .padding(.small)
                .offset(y: text.isEmpty ? 0 : -8)
        }
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

struct TextEditor_preview: PreviewProvider {
    static var previews: some View {
        VStack {
            if #available(iOS 16.0, *) {
                TextEditor(text: .constant(""))
                    .textEditorPlaceholder("Complaint", text: .constant("Text"))
                    .fieldLabelPosition(.overInput)
                    .scrollContentBackground(.hidden)

                TextEditor(text: .constant(""))
                    .textEditorPlaceholder("Complaint", text: .constant(""))
                    .fieldLabelPosition(.overInput)
                    .scrollContentBackground(.hidden)

                TextEditor(text: .constant("Text"))
                    .textEditorPlaceholder("Complaint", text: .constant("Text"))
                    .fieldLabelPosition(.overInput)
                    .scrollContentBackground(.hidden)
            }

            Spacer()
        }
        .padding()
        .background(Color.backgroundTertiary)
    }
}
