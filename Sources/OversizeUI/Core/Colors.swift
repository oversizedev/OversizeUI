//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public extension Color {
    /// Primary
    static var accent: Color {
        Color.accentColor
    }

    /// On Primary

    /// High Emphasis
    static var onPrimaryHighEmphasis: Color {
        Color("OnPrimaryHighEmphasis", bundle: .module)
    }

    /// Medium Emphasis
    static var onPrimaryMediumEmphasis: Color {
        Color("OnPrimaryMediumEmphasis", bundle: .module)
    }

    /// Disabled
    static var onPrimaryDisabled: Color {
        Color("OnPrimaryDisabled", bundle: .module)
    }

    /// Background

    /// High Emphasis
    static var backgroundPrimary: Color {
        Color("BackgroundPrimary", bundle: .module)
    }

    /// Medium Emphasis
    static var backgroundSecondary: Color {
        Color("BackgroundSecondary", bundle: .module)
    }

    /// Disabled
    static var backgroundTertiary: Color {
        Color("BackgroundTertiary", bundle: .module)
    }

    /// On Background

    /// High Emphasis
    static var onBackgroundHighEmphasis: Color {
        Color("OnBackgroundHighEmphasis", bundle: .module)
    }

    /// Medium Emphasis
    static var onBackgroundMediumEmphasis: Color {
        Color("OnBackgroundMediumEmphasis", bundle: .module)
    }

    /// Disabled
    static var onBackgroundDisabled: Color {
        Color("OnBackgroundDisabled", bundle: .module)
    }

    /// Surface
    /// High Emphasis
    static var surfacePrimary: Color {
        Color("SurfacePrimary", bundle: .module)
    }

    /// Medium Emphasis
    static var surfaceSecondary: Color {
        Color("SurfaceSecondary", bundle: .module)
    }

    /// Disabled
    static var surfaceTertiary: Color {
        Color("SurfaceTertiary", bundle: .module)
    }

    static var onSurfaceHighEmphasis: Color {
        Color("OnSurfaceHighEmphasis", bundle: .module)
    }

    /// Medium Emphasis
    static var onSurfaceMediumEmphasis: Color {
        Color("OnSurfaceMediumEmphasis", bundle: .module)
    }

    /// Disabled
    static var onSurfaceDisabled: Color {
        Color("OnSurfaceDisabled", bundle: .module)
    }

    /// Error
    static var error: Color {
        Color("Error", bundle: .module)
    }

    /// Success
    static var success: Color {
        Color("Success", bundle: .module)
    }

    /// Warning
    static var warning: Color {
        Color("Warning", bundle: .module)
    }

    /// Link
    static var link: Color {
        Color("Primary", bundle: .module)
    }

    /// Border
    static var border: Color {
        Color("Border", bundle: .module)
    }
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Accent")
                .foregroundColor(Color.onPrimaryMediumEmphasis)
                .padding()

            HStack {
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(Color.onPrimaryHighEmphasis)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(Color.onPrimaryMediumEmphasis)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(Color.onPrimaryDisabled)
                Rectangle().size(CGSize(width: 50, height: 50))
            }
            .padding(.horizontal)
        }
        .background(Color.accent)
        .padding()
    }
}
