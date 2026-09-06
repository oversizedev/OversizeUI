//
// Copyright © 2026 Alexander Romanov
// ElevationDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct ElevationDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Levels") {
                ForEach(Elevation.allCases, id: \.self) { elevation in
                    Surface {
                        Text("z\(elevation.rawValue)")
                    }
                    .elevation(elevation)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ElevationDemo()
    }
}
