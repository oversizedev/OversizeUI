//
// Copyright © 2021 Alexander Romanov
// SurfaceDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct SurfaceDemo: View {
    var body: some View {
        PageView("Surface") {
            VStack {
                Surface {
                    Text("Text")
                        .fontStyle(.title3, color: .onSurfaceHighEmphasis)
                }
                .surfaceStyle(.secondary)

                Text("Text")
                    .surface(elevation: .z4)
                    .previewLayout(.fixed(width: 414, height: 200))

                HStack {
                    Text("Text")

                    Spacer()
                }
                .surface(elevation: .z4)

                Surface { HStack {
                    Spacer()
                    Text("Text")
                    Spacer()
                }}
                .controlRadius(.zero)
                .controlPadding(.zero)
                .elevation(.z2)

                Surface { HStack {
                    Text("Text")
                    Spacer()
                }}
                .elevation(.z1)
            }
            .padding()
        }
        .leadingBar {
            BarButton(.back)
        }
    }
}

struct SurfaceDemo_Previews: PreviewProvider {
    static var previews: some View {
        SurfaceDemo()
    }
}
