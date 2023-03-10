//
// Copyright © 2021 Alexander Romanov
// TextEditorPlaceholderViewModifier.swift, created on 20.02.2023
//

import SwiftUI

@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct TextEditorPlaceholderViewModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldLabelPosition) private var fieldPlaceholderPosition: FieldLabelPosition
    @Binding private var text: String
    private let placeholder: String
    @FocusState var isFocused: Bool

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            if fieldPlaceholderPosition == .adjacent {
                HStack {
                    Text(placeholder)
                        .subheadline(.medium)
                        .foregroundColor(.onSurfaceHighEmphasis)
                    Spacer()
                }
            }

            content
                .padding(.horizontal, .xSmall)
                .padding(.top, topInputPadding)
                .padding(.bottom, 10)
                .headline(.medium)
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
                .focused($isFocused)
                .scrollContentBackground(.hidden)
                .animation(.easeIn(duration: 0.15), value: text)
        }
    }

    var topInputPadding: CGFloat {
        switch fieldPlaceholderPosition {
        case .default, .adjacent:
            return 10
        case .overInput:
            return text.isEmpty ? 8 : 22
        }
    }

    @ViewBuilder
    var labelTextView: some View {
        switch fieldPlaceholderPosition {
        case .default:
            if text.isEmpty {
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
                .opacity(0.7)
                .padding(.small)
                .offset(y: text.isEmpty ? 0 : -6)
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
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    func textEditorPlaceholder(_ placeholder: String, text: Binding<String>) -> some View {
        modifier(TextEditorPlaceholderViewModifier(placeholder: placeholder, text: text))
    }
}

@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct TextEditor_preview: PreviewProvider {
    static var previews: some View {
        VStack {
            TextEditor(text: .constant(""))
                .textEditorPlaceholder("Complaint", text: .constant("Text"))
                .fieldLabelPosition(.overInput)

            TextEditor(text: .constant(""))
                .textEditorPlaceholder("Complaint", text: .constant(""))
                .fieldLabelPosition(.overInput)

            TextEditor(text: .constant("Text"))
                .textEditorPlaceholder("Complaint", text: .constant("Text"))
                .fieldLabelPosition(.overInput)

            Spacer()
        }
        .padding()
        .background(Color.backgroundTertiary)
    }
}
