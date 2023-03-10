//
// Copyright © 2021 Alexander Romanov
// TextFieldExtended.swift, created on 07.06.2020
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
    @Environment(\.theme) private var theme: ThemeSettings

    public var placeholder: String
    @Binding public var text: String
    @Binding public var helperText: String
    @Binding public var helperStyle: FieldHelperStyle
    public var placeholderPosition: TextFieldPlaceholderPosition

    public var leadingImage: IconsNames
    public var trallingImage: IconsNames

    public var secure: Bool
    @State private var focused: Bool = false

    public init(_ placeholder: String,
                text: Binding<String>,
                helperText: Binding<String> = .constant(""),
                helperStyle: Binding<FieldHelperStyle> = .constant(.none),
                leadingImage: IconsNames = .none,
                trallingImage: IconsNames = .none,
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
                        .subheadline()
                    Spacer()
                }
            }

            VStack(spacing: 0) {
                if placeholderPosition == .insideFeield {
                    HStack {
                        Text(placeholder)
                            .subheadline()
                            .foregroundColor(.onSurfaceHighEmphasis)
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
                                  .headline()
                                  .foregroundColor(.onSurfaceHighEmphasis)
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
                    RoundedRectangle(cornerRadius: .medium, style: .continuous)
                        .stroke(focused ? Color.accent : Color.surfacePrimary, lineWidth: 4)

                ).background(RoundedRectangle(cornerRadius: .medium, style: .continuous)
                    .fill(focused ? Color.surfacePrimary : Color.surfaceSecondary))
                .cornerRadius(Radius.medium)

            if helperText != "" {
                if helperStyle == .helperText {
                    Text(helperText)
                        .subheadline()
                        .foregroundColor(.onSurfaceMediumEmphasis)
                } else if helperStyle == .errorText {
                    Text(helperText)
                        .subheadline()
                        .foregroundColor(.error)
                } else if helperStyle == .sussesText {
                    Text(helperText)
                        .subheadline()
                        .foregroundColor(.success)
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
