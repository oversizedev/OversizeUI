//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import Combine
import SwiftUI

public enum TextFieldPlaceholderPosition {
    case none
    case overField
    case insideFeield
    case standart
}

public struct TextFieldExtended: View {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    public var placeholder: String
    @Binding public var text: String
    @Binding public var helperText: String
    @Binding public var helperStyle: TextFieldHelperStyle
    public var placeholderPosition: TextFieldPlaceholderPosition

    public var leadingImage: Icons
    public var trallingImage: Icons

    public var secure: Bool
    @State private var focused: Bool = false

    public init(_ placeholder: String,
                text: Binding<String>,
                helperText: Binding<String> = .constant(""),
                helperStyle: Binding<TextFieldHelperStyle> = .constant(.none),
                leadingImage: Icons = .none,
                trallingImage: Icons = .none,
                placeholderPosition: TextFieldPlaceholderPosition = .overField,
                secure: Bool = false
                // contentType: UITextContentType = .
    ) {
        self.placeholder = placeholder
        _text = text
        _helperText = helperText
        _helperStyle = helperStyle
        self.leadingImage = leadingImage
        self.trallingImage = trallingImage
        self.placeholderPosition = placeholderPosition
        self.secure = secure
    }

    public var body: some View {
        VStack(alignment: .leading) {
            if placeholderPosition == .overField {
                HStack {
                    Text(placeholder)
                        .fontStyle(.subtitle2)
                    Spacer()
                }
            }

            VStack(spacing: 0) {
                if placeholderPosition == .insideFeield {
                    HStack {
                        Text(placeholder)
                            .fontStyle(.subtitle2, color: .onSurfaceHighEmphasis)
                        Spacer()
                    }
                    .padding(.bottom, Space.xxSmall)
                }

                HStack {
                    if leadingImage != .none {
                        Icon(leadingImage)
                    }

                    if secure {
                        SecureField(placeholderPosition == .standart ? placeholder : "", text: $text)
                    } else {
                        TextField(placeholderPosition == .standart ? placeholder : "", text: $text,
                                  onEditingChanged: { focused in
                                      self.focused = focused
                                  })
                            .fontStyle(.subtitle1, color: .onSurfaceHighEmphasis)
                    }

                    if trallingImage != .none {
                        Icon(trallingImage)
                    }

                    if helperStyle == .errorText {
                        Image("alert-circle", bundle: .module)
                            .renderingMode(.template)
                            .foregroundColor(Color.error)
                            .frame(width: 20, height: 20)
                    }

                    if helperStyle == .sussesText {
                        Image("check", bundle: .module)
                            .renderingMode(.template)
                            .foregroundColor(Color.success)
                            .frame(width: 20, height: 20)
                    }
                }

            }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(focused ? Color.accent : Color.surfacePrimary, lineWidth: 4)

                ).background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(focused ? Color.surfacePrimary : Color.surfaceSecondary))
                .cornerRadius(Radius.medium)

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

// swiftlint:disable all
struct TextFieldExtended_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 24) {
                TextFieldExtended("Text", text: .constant("Text"))

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.helperText), leadingImage: .calendar)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.helperText), leadingImage: .calendar)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.errorText), leadingImage: .calendar)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.sussesText), leadingImage: .calendar)

                TextFieldExtended("Text", text: .constant("Текст"), placeholderPosition: .insideFeield)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.helperText), leadingImage: .calendar, placeholderPosition: .insideFeield)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.helperText), leadingImage: .calendar, placeholderPosition: .insideFeield)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.errorText), leadingImage: .calendar, placeholderPosition: .insideFeield)

                TextFieldExtended("Text", text: .constant("Text"), helperText: .constant("Helper"), helperStyle: .constant(.sussesText), leadingImage: .calendar, placeholderPosition: .insideFeield)

            }.padding()
        }
        .previewLayout(.fixed(width: 375, height: 1300))
    }
}
