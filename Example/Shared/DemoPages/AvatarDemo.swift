//
// Copyright © 2021 Alexander Romanov
// AvatarDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct AvatarDemo: View {
    var body: some View {
        PageView("Avatars") {
            LazyVStack(spacing: .xSmall) {
                #if os(iOS) || os(macOS) || os(watchOS)
                Group {
                    Avatar(firstName: "Jhon")
                        .controlSize(.small)
                        .previewDisplayName("Only firsy name")

                    Avatar(firstName: "Jhon", lastName: "Smith")
                        .controlSize(.small)

                    Avatar(avatar: Image("empty"))
                        .controlSize(.small)

                    Avatar(firstName: "Jhon", lastName: "Smith", avatar: Image("empty"))
                        .controlSize(.small)
                }

                Group {
                    Avatar(firstName: "Jhon")
                        .controlSize(.regular)
                        .previewDisplayName("Only firsy name")

                    Avatar(firstName: "Jhon", lastName: "Smith")
                        .controlSize(.regular)

                    Avatar(avatar: Image("empty"))
                        .controlSize(.regular)

                    Avatar(firstName: "Jhon", lastName: "Smith", avatar: Image("empty"))
                        .controlSize(.regular)
                }
                Group {
                    Avatar(firstName: "Jhon")
                        .controlSize(.large)

                    Avatar(firstName: "Jhon", lastName: "Smith")
                        .controlSize(.large)

                    Avatar(avatar: Image("empty"))
                        .controlSize(.large)

                    Avatar(firstName: "Jhon", lastName: "Smith", avatar: Image("empty"))
                        .controlSize(.large)
                }
                #endif
            }
        }
        .leadingBar {
            BarButton(.back)
        }
    }
}

struct AvatarDemo_Previews: PreviewProvider {
    static var previews: some View {
        AvatarDemo()
    }
}
