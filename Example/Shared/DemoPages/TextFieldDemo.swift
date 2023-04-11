//
// Copyright © 2021 Alexander Romanov
// TextFieldDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct TextFieldDemo: View {
    @State var text = ""

    var body: some View {
        PageView("Text Fields") {
            VStack(spacing: .xSmall) {
                fields

                fields
                    .fieldLabelPosition(.adjacent)

                fields
                    .fieldLabelPosition(.overInput)

            }.padding()
        }
        .leadingBar {
            BarButton(.back)
        }
    }

    var fields: some View {
        VStack(spacing: .xSmall) {
            TextField("Text", text: $text)
                .textFieldStyle(.default)

            TextField("Text", text: $text)
                .textFieldStyle(.placeholder("Placeholder"))

            TextField("Text", text: $text)
                .textFieldStyle(.placeholder("Placeholder", text: $text))

            TextField("Text", text: $text, prompt: Text("Promt"))
                .textFieldStyle(.placeholder("Placeholder", text: $text))

            TextField("Text", text: $text)
                .textFieldStyle(.placeholder("Placeholder", text: $text))
                .fieldHelper(.constant("Help"), style: .constant(.helperText))

            TextField("Text", text: $text)
                .textFieldStyle(.placeholder("Placeholder", text: $text))
                .fieldHelper(.constant("Ok"), style: .constant(.sussesText))

            TextField("Text", text: $text)
                .textFieldStyle(.placeholder("Placeholder", text: $text))
                .fieldHelper(.constant("Error"), style: .constant(.errorText))

        }.padding()
    }
}

struct TextFielsDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemo()
    }
}
