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
                Group {
                    AvatarView(firstName: "Jhon")
                        .controlSize(.small)
                        .previewDisplayName("Only firsy name")

                    AvatarView(firstName: "Jhon", lastName: "Smith")
                        .controlSize(.small)

                    AvatarView(avatar: Image("empty"))
                        .controlSize(.small)

                    AvatarView(firstName: "Jhon", lastName: "Smith", avatar: Image("empty"))
                        .controlSize(.small)
                }

                Group {
                    AvatarView(firstName: "Jhon")
                        .controlSize(.regular)
                        .previewDisplayName("Only firsy name")

                    AvatarView(firstName: "Jhon", lastName: "Smith")
                        .controlSize(.regular)

                    AvatarView(avatar: Image("empty"))
                        .controlSize(.regular)

                    AvatarView(firstName: "Jhon", lastName: "Smith", avatar: Image("empty"))
                        .controlSize(.regular)
                }
                Group {
                    AvatarView(firstName: "Jhon")
                        .controlSize(.large)

                    AvatarView(firstName: "Jhon", lastName: "Smith")
                        .controlSize(.large)

                    AvatarView(avatar: Image("empty"))
                        .controlSize(.large)

                    AvatarView(firstName: "Jhon", lastName: "Smith", avatar: Image("empty"))
                        .controlSize(.large)
                }
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
