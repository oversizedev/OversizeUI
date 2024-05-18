//
// Copyright © 2021 Alexander Romanov
// TextField.swift, created on 07.06.2020
//

import SwiftUI

// swiftlint:disable identifier_name
public struct LabeledTextFieldStyle: TextFieldStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldLabelPosition) private var fieldPlaceholderPosition: FieldLabelPosition
    @Environment(\.fieldPosition) private var fieldPosition: FieldPosition
    @FocusState var isFocused: Bool
    @Binding private var text: String
    private let placeholder: String

    public init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        _text = text
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            if fieldPlaceholderPosition == .adjacent {
                HStack {
                    Text(placeholder)
                        .subheadline(.medium)
                        .foregroundColor(.onSurfaceHighEmphasis)
                    Spacer()
                }
            }
            ZStack(alignment: .leading) {
                labelTextView
                configuration
                    .headline(.medium)
                    .foregroundColor(.onSurfaceHighEmphasis)
                    .offset(y: fieldOffset)
                    .focused($isFocused)
                #if os(macOS)
                    .textFieldStyle(.plain)
                    .padding(.xxSmall)
                #else
                    .padding(.vertical, fieldPlaceholderPosition == .overInput ? .xxxSmall : .zero)
                    .padding()

                #endif
            }
            .background(fieldBackground)
            .overlay(overlay)
        }
        .animation(.easeIn(duration: 0.15), value: text)
    }

    @ViewBuilder
    private var fieldBackground: some View {
        switch fieldPosition {
        case .default:
            RoundedRectangle(
                cornerRadius: Radius.medium,
                style: .continuous
            )
            .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
        case .top, .bottom, .center:
            #if os(iOS)
            RoundedRectangleCorner(radius: Radius.medium, corners: backgroundShapeCorners)
                .fill(isFocused ? Color.surfacePrimary : Color.surfaceSecondary)
            #endif
        }
    }

    #if os(iOS)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    private var backgroundShapeCorners: UIRectCorner {
        switch fieldPosition {
        case .default:
            [.allCorners]
        case .top:
            [.topLeft, .topRight]
        case .bottom:
            [.bottomLeft, .bottomRight]
        case .center:
            []
        }
    }
    #endif

    private var fieldOffset: CGFloat {
        switch fieldPlaceholderPosition {
        case .default:
            0
        case .adjacent:
            0
        case .overInput:
            text.isEmpty ? 0 : 10
        }
    }

    @ViewBuilder
    private var overlay: some View {
        switch fieldPosition {
        case .default:
            RoundedRectangle(
                cornerRadius: Radius.medium,
                style: .continuous
            )
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
        case .top, .bottom, .center:
            #if os(iOS)
            RoundedRectangleCorner(radius: Radius.medium, corners: backgroundShapeCorners)
                .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
            #else
            RoundedRectangle(
                cornerRadius: Radius.medium,
                style: .continuous
            )
            .stroke(overlayBorderColor, lineWidth: isFocused ? 2 : CGFloat(theme.borderSize))
            #endif
        }
    }

    @ViewBuilder
    private var labelTextView: some View {
        switch fieldPlaceholderPosition {
        case .default:
            if isFocused {
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
                .padding(.small)
                .offset(y: text.isEmpty ? 0 : -13)
                .opacity(text.isEmpty ? 0 : 1)
        }
    }

    private var overlayBorderColor: Color {
        if isFocused {
            Color.accentColor
        } else if theme.borderTextFields {
            Color.border
        } else {
            Color.clear
        }
    }
}

public extension TextFieldStyle where Self == LabeledTextFieldStyle {
    static var `default`: LabeledTextFieldStyle {
        LabeledTextFieldStyle(placeholder: "", text: .constant(""))
    }

    static func placeholder(_ placeholder: String, text: Binding<String> = .constant("")) -> LabeledTextFieldStyle {
        LabeledTextFieldStyle(placeholder: placeholder, text: text)
    }
}

struct LabeledTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(.default)

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(DefaultPlaceholderTextFieldStyle())
                .fieldHelper(.constant("Help"), style: .constant(.helperText))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))
                .fieldHelper(.constant("Ok"), style: .constant(.sussesText))

            TextField("Text", text: .constant("Placeholder"))
                .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))
                .fieldHelper(.constant("Error"), style: .constant(.errorText))

        }.padding()
            .previewLayout(.sizeThatFits)
    }
}
