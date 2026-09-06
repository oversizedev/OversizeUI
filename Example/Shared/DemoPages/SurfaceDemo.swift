//
// Copyright © 2021 Alexander Romanov
// SurfaceDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct SurfaceDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Styles") {
                Surface {
                    Text("Primary")
                        .onSurfacePrimary()
                }

                Surface {
                    Text("Secondary")
                        .onSurfacePrimary()
                }
                .surfaceStyle(.secondary)
            }

            DemoSectionView("Elevation") {
                Surface {
                    Text("z1")
                }
                .elevation(.z1)

                Surface {
                    Text("z2")
                }
                .elevation(.z2)

                Surface {
                    Text("z4")
                }
                .elevation(.z4)
            }

            DemoSectionView("Modifier") {
                Text("Applied with .surface()")
                    .surface()
                    .elevation(.z2)
            }

            DemoSectionView("Margins and radius") {
                Surface {
                    Text("No margins, no radius")
                }
                .controlRadius(.zero)
                .surfaceContentMargins(.zero)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SurfaceDemo()
    }
}
