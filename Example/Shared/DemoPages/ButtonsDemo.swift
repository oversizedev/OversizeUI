//
// Copyright © 2021 Alexander Romanov
// ButtonsDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct ButtonsDemo: View {
    var body: some View {
        PageView("Buttons") {
            VStack(spacing: .xSmall) {
                Button("Button") { print(#function) }
                    .buttonStyle(.primary)
                    .elevation(.z2)

                Button("Button") { print(#function) }
                    .buttonStyle(.secondary)
                    .elevation(.z2)

                Button("Button") { print(#function) }
                    .buttonStyle(.tertiary)

                Button("Button") { print(#function) }
                    .buttonStyle(.quaternary)

                Button("Button") { print(#function) }
                    .accent()
                    .buttonStyle(.primary)
                    .controlRadius(.xLarge)

                Button("Button") { print(#function) }
                    .buttonStyle(.quaternary)
                    .accent()

                Button(role: .cancel) {
                    print(#function)
                } label: {
                    Text("Button")
                }
                .buttonStyle(.primary)

                Button(role: .destructive) {
                    print(#function)
                } label: {
                    Text("Button")
                }
                .buttonStyle(.primary)

                #if os(iOS) || os(macOS) || os(watchOS)
                    HStack {
                        Button("Button") { print(#function) }
                            .buttonStyle(.secondary)
                            .accent()
                            .controlSize(.small)
                            .elevation(.z2)

                        Button("Button") { print(#function) }
                            .buttonStyle(.secondary)
                            .controlSize(.mini)
                            .elevation(.z2)

                        Button {
                            print(#function)
                        } label: {
                            Image(systemName: "archivebox")
                        }
                        .controlSize(.small)
                        .buttonStyle(.secondary)
                        .elevation(.z2)
                    }
                #endif

            }.padding()
        }
        .leadingBar {
            BarButton(.back)
        }
    }
}

struct BittonsDemo_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsDemo()
    }
}
