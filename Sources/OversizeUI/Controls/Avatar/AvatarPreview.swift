//
// Copyright © 2023 Alexander Romanov
// AvatarPreview.swift, created on 10.03.2023
//

import SwiftUI

struct AvatarPreview: View {
    var body: some View {
        VStack(alignment: .leading) {
            #if os(tvOS)
                avatarsStack
            #else
                avatarsStack
                    .controlSize(.mini)

                avatarsStack
                    .controlSize(.small)

                avatarsStack
                    .controlSize(.regular)

                avatarsStack
                    .controlSize(.large)

            #endif
        }
    }

    var avatarsStack: some View {
        HStack {
            Avatar(firstName: "Swift")

            Avatar(firstName: "Swift", lastName: "Apple")

            Avatar(avatar: Image("Avatar", bundle: .module))

            Avatar(icon: Image(IconsNames.image.rawValue, bundle: .module))
        }
    }
}

struct Avatar_Preview: PreviewProvider {
    static var previews: some View {
        AvatarPreview()
    }
}
