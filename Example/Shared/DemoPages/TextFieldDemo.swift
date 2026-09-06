//
// Copyright © 2021 Alexander Romanov
// TextFieldDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct TextFieldDemo: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var helperText = "Enter a valid email"
    @State private var helperStyle: FieldHelperStyle = .helperText

    var body: some View {
        DemoScreen {
            DemoSectionView("Default") {
                TextField("Name", text: $name)
                    .textFieldStyle(.default)
                    .accessibilityIdentifier("nameField")
            }

            DemoSectionView("Label position") {
                TextField("Adjacent", text: $name)
                    .textFieldStyle(.default)
                    .fieldLabelPosition(.adjacent)

                TextField("Over input", text: $name)
                    .textFieldStyle(.default)
                    .fieldLabelPosition(.overInput)
            }

            DemoSectionView("Helper") {
                TextField("Email", text: $email)
                    .textFieldStyle(.default)
                    .fieldHelper($helperText, style: $helperStyle)
                    .accessibilityIdentifier("emailField")

                Button("Toggle error") {
                    helperStyle = helperStyle == .errorText ? .helperText : .errorText
                    helperText = helperStyle == .errorText ? "Invalid email" : "Enter a valid email"
                }
                .buttonStyle(.tertiary)
                .accessibilityIdentifier("toggleHelperButton")
            }

            DemoSectionView("Secure") {
                SecureField("Password", text: $password)
                    .textFieldStyle(.default)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TextFieldDemo()
    }
}
