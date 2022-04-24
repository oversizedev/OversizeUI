//
// Copyright © 2022 Alexander Romanov
// FieldScreenView.swift
//

import SwiftUI

public struct FieldScreenView: View {
    public let label: String
    public var placeholder: String
    @Binding public var text: String
    @Binding public var helperText: String
    @Binding public var showHelper: Bool
    @State var offset = CGPoint(x: 0, y: 0)

    public var leadingImage: IconsNames
    public var trallingImage: IconsNames

    public var buttonText: LocalizedStringKey
    public var action: () -> Void

    @Environment(\.presentationMode) var presentationMode

    @State private var focused: Bool = false

    public init(_ label: String,
                placeholder: String,
                text: Binding<String>,
                helperText: Binding<String> = .constant(""),
                showHelper: Binding<Bool> = .constant(false),
                leadingImage: IconsNames = .none,
                trallingImage: IconsNames = .none,
                buttonText: LocalizedStringKey = "",
                buttonAction: @escaping () -> Void)
    {
        self.label = label
        self.placeholder = placeholder
        _text = text
        _helperText = helperText
        _showHelper = showHelper
        self.leadingImage = leadingImage
        self.trallingImage = trallingImage
        self.buttonText = buttonText
        action = buttonAction
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            VStack(spacing: 0) {
                HStack {
                    if leadingImage != .none {
                        Icon(leadingImage)
                    }

                    TextField(placeholder, text: $text, onEditingChanged: { focused in
                        self.focused = focused
                    })
                    .fontStyle(.largeTitle, color: .onSurfaceHighEmphasis)
                    .multilineTextAlignment(.center)

                    if trallingImage != .none {
                        Icon(trallingImage)
                    }
                }

            }.padding()

            if helperText != "" {
                Text(helperText)
                    .fontStyle(.subtitle2, color: .onSurfaceMediumEmphasis)
            }

            Spacer()

            Button(action: buttonAction, label: {
                Text(buttonText, bundle: .module)
            })
            .style(.primary, size: .large)
            .padding()
        }
        .navigationBar("App", style: .fixed($offset)) {
            BarButton(type: .close)
        } trailingBar: {} bottomBar: {}
    }

    func buttonAction() {
        action()
        presentationMode.wrappedValue.dismiss()
    }
}

struct FieldScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FieldScreenView("Your name", placeholder: "Alexander", text: .constant("Alexander"), buttonAction: {})
    }
}
