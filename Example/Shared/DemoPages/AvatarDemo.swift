//
// Copyright © 2021 Alexander Romanov
// AvatarDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct AvatarDemo: View {
    var body: some View {
        DemoScreen {
            #if os(iOS) || os(macOS) || os(watchOS)
            DemoSectionView("Sizes") {
                HStack(spacing: .small) {
                    Avatar(firstName: "John")
                        .controlSize(.small)

                    Avatar(firstName: "John", lastName: "Smith")
                        .controlSize(.regular)

                    Avatar(firstName: "John", lastName: "Smith")
                        .controlSize(.large)
                }
            }

            DemoSectionView("Content") {
                HStack(spacing: .small) {
                    Avatar(firstName: "John", lastName: "Smith")

                    Avatar(icon: Image.Base.profile)

                    Avatar(avatar: Image(systemName: "swift"))
                }
            }

            DemoSectionView("Background and stroke") {
                HStack(spacing: .small) {
                    Avatar(firstName: "AI", lastName: "Bot")
                        .avatarBackground(.gradient([.blue, .purple]))
                        .avatarOnBackground(.white)

                    Avatar(firstName: "John", lastName: "Smith")
                        .avatarBackground(.color(.accent))
                        .avatarOnBackground(.onPrimary)

                    Avatar(firstName: "John", lastName: "Smith")
                        .avatarStroke(.accent, lineWidth: 2)
                }
            }
            #endif
        }
    }
}

#Preview {
    NavigationStack {
        AvatarDemo()
    }
}
