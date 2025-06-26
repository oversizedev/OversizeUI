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
                        .foregroundColor(.onSurfacePrimary)
                    Spacer()
                }
            }

            content
                .padding(padding)
                .headline(.medium)
                .onSurfacePrimaryForeground()
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: fieldRadius, style: .continuous)
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

    private var fieldRadius: Radius {
        #if os(macOS)
        return .xSmall
        #else
        return .medium
        #endif
    }

    var padding: EdgeInsets {
        switch fieldPlaceholderPosition {
        case .default, .adjacent:
            #if os(macOS)
            return .init(
                top: 10,
                leading: Space.xSmall.rawValue,
                bottom: 10,
                trailing: Space.xSmall.rawValue
            )
            #else
            return .init(
                top: 10,
                leading: Space.xSmall.rawValue,
                bottom: 10,
                trailing: Space.xSmall.rawValue
            )
            #endif
        case .overInput:
            #if os(macOS)
            return .init(
                top: text.isEmpty ? 13 : 22,
                leading: Space.xxSmall.rawValue,
                bottom: 10,
                trailing: Space.xxSmall.rawValue
            )
            #else
            return .init(
                top: text.isEmpty ? 8 : 22,
                leading: Space.xSmall.rawValue,
                bottom: 10,
                trailing: Space.xSmall.rawValue
            )

            #endif
        }
    }

    var labelPadding: EdgeInsets {
        switch fieldPlaceholderPosition {
        case .default, .adjacent:
            #if os(macOS)
            return .init(Space.xSmall)
            #else
            return .init(Space.xSmall)
            #endif
        case .overInput:
            #if os(macOS)
            return .init(horizontal: Space.xSmall, vertical: Space.xSmall)
            #else
            return .init(Space.xxSmall)
            #endif
        }
    }

    @ViewBuilder
    var labelTextView: some View {
        switch fieldPlaceholderPosition {
        case .default:
            if text.isEmpty {
                Text(placeholder)
                    .subheadline()
                    .onSurfaceTertiaryForeground()
                    .opacity(0.7)
                    .padding(labelPadding)
            }
        case .adjacent:
            EmptyView()
        case .overInput:
            Text(placeholder)
                .font(text.isEmpty ? .headline : .subheadline)
                .fontWeight(text.isEmpty ? .medium : .semibold)
                .onSurfaceTertiaryForeground()
                .opacity(0.7)
                .padding(labelPadding)
                .offset(y: text.isEmpty ? 0 : -6)
        }
    }

    @ViewBuilder
    var overlay: some View {
        RoundedRectangle(cornerRadius: fieldRadius, style: .continuous)
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
    }

    var overlayBorderColor: Color {
        if isFocused {
            Color.accentColor
        } else if theme.borderTextFields {
            Color.border
        } else {
            Color.clear
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
                .fieldPosition(.top)

            TextEditor(text: .constant("Text"))
                .textEditorPlaceholder("Complaint", text: .constant("Text"))
                .fieldLabelPosition(.overInput)
                .fieldPosition(.bottom)

            Spacer()
        }
        .padding()
        .background(Color.backgroundTertiary)
    }
}
