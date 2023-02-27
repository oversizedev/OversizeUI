//
// Copyright © 2021 Alexander Romanov
// Colors.swift, created on 11.09.2021
//

import SwiftUI

public extension Color {
    // MARK: Primary

    static var accent: Color {
        Color.accentColor
    }

    // MARK: - On Primary

    /// On Primary High Emphasis
    static var onPrimaryHighEmphasis: Color {
        Color("OnPrimaryHighEmphasis", bundle: .module)
    }

    /// On Primary Medium Emphasis
    static var onPrimaryMediumEmphasis: Color {
        Color("OnPrimaryMediumEmphasis", bundle: .module)
    }

    /// On Primary Disabled
    static var onPrimaryDisabled: Color {
        Color("OnPrimaryDisabled", bundle: .module)
    }

    // MARK: - Background

    /// Background Primary
    static var backgroundPrimary: Color {
        Color("BackgroundPrimary", bundle: .module)
    }

    /// Background Secondary
    static var backgroundSecondary: Color {
        Color("BackgroundSecondary", bundle: .module)
    }

    /// Background Tertiary
    static var backgroundTertiary: Color {
        Color("BackgroundTertiary", bundle: .module)
    }

    // MARK: - On Background

    /// On Background High Emphasis
    static var onBackgroundHighEmphasis: Color {
        Color("OnBackgroundHighEmphasis", bundle: .module)
    }

    /// On BackgroundMedium Emphasis
    static var onBackgroundMediumEmphasis: Color {
        Color("OnBackgroundMediumEmphasis", bundle: .module)
    }

    /// On Background Disabled
    static var onBackgroundDisabled: Color {
        Color("OnBackgroundDisabled", bundle: .module)
    }

    // MARK: - Surface

    /// Surface Primary
    static var surfacePrimary: Color {
        Color("SurfacePrimary", bundle: .module)
    }

    /// Surface Secondary
    static var surfaceSecondary: Color {
        Color("SurfaceSecondary", bundle: .module)
    }

    /// Surface Tertiary
    static var surfaceTertiary: Color {
        Color("SurfaceTertiary", bundle: .module)
    }

    /// On Surface High Emphasis
    static var onSurfaceHighEmphasis: Color {
        Color("OnSurfaceHighEmphasis", bundle: .module)
    }

    /// On Surface Medium Emphasis
    static var onSurfaceMediumEmphasis: Color {
        Color("OnSurfaceMediumEmphasis", bundle: .module)
    }

    /// On Surface Disabled
    static var onSurfaceDisabled: Color {
        Color("OnSurfaceDisabled", bundle: .module)
    }

    // MARK: - Other

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

// MARK: - Foreground Color Extension

public extension View {
    func onPrimaryHighEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onPrimaryHighEmphasis)
    }

    func onPrimaryMediumEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onPrimaryMediumEmphasis)
    }

    func onPrimaryDisabledForegroundColor() -> some View {
        foregroundColor(Color.onPrimaryDisabled)
    }

    func backgroundPrimaryForegroundColor() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    func backgroundSecondaryForegroundColor() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    func backgroundTertiaryForegroundColor() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    func onBackgroundHighEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onBackgroundHighEmphasis)
    }

    func onBackgroundMediumEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onBackgroundMediumEmphasis)
    }

    func onBackgroundDisabledForegroundColor() -> some View {
        foregroundColor(Color.onBackgroundDisabled)
    }

    func surfacePrimaryForegroundColor() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    func surfaceSecondaryForegroundColor() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    func surfaceTertiaryForegroundColor() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    func onSurfaceHighEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onSurfaceHighEmphasis)
    }

    func onSurfaceMediumEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onSurfaceMediumEmphasis)
    }

    func onSurfaceDisabledForegroundColor() -> some View {
        foregroundColor(Color.onSurfaceDisabled)
    }

    func accentForegroundColor() -> some View {
        foregroundColor(Color.accentColor)
    }

    func errorForegroundColor() -> some View {
        foregroundColor(Color.error)
    }

    func successForegroundColor() -> some View {
        foregroundColor(Color.success)
    }

    func warningForegroundColor() -> some View {
        foregroundColor(Color.warning)
    }

    func linkForegroundColor() -> some View {
        foregroundColor(Color.link)
    }

    func borderForegroundColor() -> some View {
        foregroundColor(Color.border)
    }
}

// MARK: - Fill Color Extension

public extension Shape {
    func fillOnPrimaryHighEmphasis() -> some View {
        fill(Color.onPrimaryHighEmphasis)
    }

    func fillOnPrimaryMediumEmphasis() -> some View {
        fill(Color.onPrimaryMediumEmphasis)
    }

    func fillOnPrimaryDisabled() -> some View {
        fill(Color.onPrimaryDisabled)
    }

    func fillAccent() -> some View {
        fill(Color.accentColor)
    }

    func fillBackgroundPrimary() -> some View {
        fill(Color.backgroundPrimary)
    }

    func fillBackgroundSecondary() -> some View {
        fill(Color.backgroundSecondary)
    }

    func fillBackgroundTertiary() -> some View {
        fill(Color.backgroundTertiary)
    }

    func fillOnBackgroundHighEmphasis() -> some View {
        fill(Color.onBackgroundHighEmphasis)
    }

    func fillOnBackgroundMediumEmphasis() -> some View {
        fill(Color.onBackgroundMediumEmphasis)
    }

    func fillOnBackgroundDisabled() -> some View {
        fill(Color.onBackgroundDisabled)
    }

    func fillSurfacePrimary() -> some View {
        fill(Color.surfacePrimary)
    }

    func fillSurfaceSecondary() -> some View {
        fill(Color.surfaceSecondary)
    }

    func fillSurfaceTertiary() -> some View {
        fill(Color.surfaceTertiary)
    }

    func fillOnSurfaceHighEmphasis() -> some View {
        fill(Color.onSurfaceHighEmphasis)
    }

    func fillOnSurfaceMediumEmphasis() -> some View {
        fill(Color.onSurfaceMediumEmphasis)
    }

    func fillOnSurfaceDisabled() -> some View {
        fill(Color.onSurfaceDisabled)
    }

    func fillError() -> some View {
        fill(Color.error)
    }

    func fillSuccess() -> some View {
        fill(Color.success)
    }

    func fillWarning() -> some View {
        fill(Color.warning)
    }

    func fillLink() -> some View {
        fill(Color.link)
    }

    func fillBorder() -> some View {
        fill(Color.border)
    }
}

public extension View {
    @available(*, deprecated, renamed: "onPrimaryHighEmphasisForegroundColor")
    func foregroundOnPrimaryHighEmphasis() -> some View {
        foregroundColor(Color.onPrimaryHighEmphasis)
    }

    @available(*, deprecated, renamed: "onPrimaryMediumEmphasisForegroundColor")
    func foregroundOnPrimaryMediumEmphasis() -> some View {
        foregroundColor(Color.onPrimaryMediumEmphasis)
    }

    @available(*, deprecated, renamed: "onPrimaryDisabledForegroundColor")
    func foregroundOnPrimaryDisabled() -> some View {
        foregroundColor(Color.onPrimaryDisabled)
    }

    @available(*, deprecated, renamed: "accentForegroundColor")
    func foregroundAccent() -> some View {
        foregroundColor(Color.accentColor)
    }

    @available(*, deprecated, renamed: "backgroundPrimaryForegroundColor")
    func foregroundBackgroundPrimary() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    @available(*, deprecated, renamed: "backgroundSecondaryForegroundColor")
    func foregroundBackgroundSecondary() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    @available(*, deprecated, renamed: "backgroundTertiaryForegroundColor")
    func foregroundBackgroundTertiary() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    @available(*, deprecated, renamed: "onBackgroundHighEmphasisForegroundColor")
    func foregroundOnBackgroundHighEmphasis() -> some View {
        foregroundColor(Color.onBackgroundHighEmphasis)
    }

    @available(*, deprecated, renamed: "onBackgroundMediumEmphasisForegroundColor")
    func foregroundOnBackgroundMediumEmphasis() -> some View {
        foregroundColor(Color.onBackgroundMediumEmphasis)
    }

    @available(*, deprecated, renamed: "onBackgroundDisabledForegroundColor")
    func foregroundOnBackgroundDisabled() -> some View {
        foregroundColor(Color.onBackgroundDisabled)
    }

    @available(*, deprecated, renamed: "surfacePrimaryForegroundColor")
    func foregroundSurfacePrimary() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    @available(*, deprecated, renamed: "surfaceSecondaryForegroundColor")
    func foregroundSurfaceSecondary() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    @available(*, deprecated, renamed: "aurfaceTertiaryForegroundColor")
    func foregroundSurfaceTertiary() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    @available(*, deprecated, renamed: "onSurfaceHighEmphasisForegroundColor")
    func foregroundOnSurfaceHighEmphasis() -> some View {
        foregroundColor(Color.onSurfaceHighEmphasis)
    }

    @available(*, deprecated, renamed: "onSurfaceMediumEmphasisForegroundColor")
    func foregroundOnSurfaceMediumEmphasis() -> some View {
        foregroundColor(Color.onSurfaceMediumEmphasis)
    }

    @available(*, deprecated, renamed: "onSurfaceDisabledForegroundColor")
    func foregroundOnSurfaceDisabled() -> some View {
        foregroundColor(Color.onSurfaceDisabled)
    }

    @available(*, deprecated, renamed: "errorForegroundColor")
    func foregroundError() -> some View {
        foregroundColor(Color.error)
    }

    @available(*, deprecated, renamed: "successForegroundColor")
    func foregroundSuccess() -> some View {
        foregroundColor(Color.success)
    }

    @available(*, deprecated, renamed: "warningForegroundColor")
    func foregroundWarning() -> some View {
        foregroundColor(Color.warning)
    }

    @available(*, deprecated, renamed: "linkForegroundColor")
    func foregroundLink() -> some View {
        foregroundColor(Color.link)
    }

    @available(*, deprecated, renamed: "borderForegroundColor")
    func foregroundBorder() -> some View {
        foregroundColor(Color.border)
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
        .background(Color.accentColor)
        .padding()
    }
}
