//
// Copyright © 2022 Alexander Romanov
// ButtonsDemo.swift
//

import OversizeUI
import SwiftUI

struct ButtonsDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .xSmall) {
                Button("Button") { print(#function) }
                    .style(.primary)

                Button("Button") { print(#function) }
                    .style(.primary)

                Button("Button") { print(#function) }
                    .style(.secondary)

                Button("Button") { print(#function) }
                    .style(.gray)

                Button("Button") { print(#function) }
                    .style(.text)

                Button("Button") { print(#function) }
                    .style(.link)

                Button("Button") { print(#function) }
                    .style(.deleteLink)

                Button("Button") { print(#function) }
                    .style(.secondary, size: .medium, rounded: .full, width: .full, shadow: true)

            }.padding()
        }
        .navigationBarTitle("Buttons", displayMode: .inline)
    }
}

struct BittonsDemo_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsDemo()
    }
}
