//
// Copyright © 2021 Alexander Romanov
// TextFieldDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct TextFieldDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .xSmall) {
                TextField("Text", text: .constant("Placeholder"))
                    .textFieldStyle(DefaultPlaceholderTextFieldStyle())

                TextField("Text", text: .constant("Placeholder"))
                    .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))

                TextField("Text", text: .constant("Placeholder"))
                    .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))

                TextField("Text", text: .constant("Placeholder"))
                    .textFieldStyle(DefaultPlaceholderTextFieldStyle())
                    .helper(.constant("Help"), style: .constant(.helperText))

                TextField("Text", text: .constant("Placeholder"))
                    .textFieldStyle(OverPlaceholderTextFieldStyle(placeholder: "Label"))
                    .helper(.constant("Ok"), style: .constant(.sussesText))

                TextField("Text", text: .constant("Placeholder"))
                    .textFieldStyle(InsidePlaceholderTextFieldStyle(placeholder: "Label"))
                    .helper(.constant("Error"), style: .constant(.errorText))

            }.padding()
        }

        .navigationTitle("Text fields")
    }
}

struct TextFielsDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemo()
    }
}
