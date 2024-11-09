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
    static var onPrimary: Color {
        Color("OnPrimaryHighEmphasis", bundle: .module)
    }

    /// On Primary Medium Emphasis
    static var onPrimarySecondary: Color {
        Color("OnPrimaryMediumEmphasis", bundle: .module)
    }

    /// On Primary Disabled
    static var onPrimaryTertiary: Color {
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
    static var onBackgroundPrimary: Color {
        Color("OnBackgroundHighEmphasis", bundle: .module)
    }

    /// On BackgroundMedium Emphasis
    static var onBackgroundSecondary: Color {
        Color("OnBackgroundMediumEmphasis", bundle: .module)
    }

    /// On Background Disabled
    static var onBackgroundTertiary: Color {
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
    static var onSurfacePrimary: Color {
        Color("OnSurfaceHighEmphasis", bundle: .module)
    }

    /// On Surface Medium Emphasis
    static var onSurfaceSecondary: Color {
        Color("OnSurfaceMediumEmphasis", bundle: .module)
    }

    /// On Surface Disabled
    static var onSurfaceTertiary: Color {
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
    nonisolated func onPrimaryForeground() -> some View {
        foregroundColor(Color.onPrimary)
    }

    nonisolated func onPrimarySecondaryForeground() -> some View {
        foregroundColor(Color.onPrimarySecondary)
    }

    nonisolated func onPrimaryTertiaryForeground() -> some View {
        foregroundColor(Color.onPrimaryTertiary)
    }

    nonisolated func backgroundPrimary() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    nonisolated func backgroundSecondaryForeground() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    nonisolated func backgroundTertiaryForeground() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    nonisolated func onBackgroundPrimaryForeground() -> some View {
        foregroundColor(Color.onBackgroundPrimary)
    }

    nonisolated func onBackgroundSecondaryForeground() -> some View {
        foregroundColor(Color.onBackgroundSecondary)
    }

    nonisolated func onBackgroundTertiaryForeground() -> some View {
        foregroundColor(Color.onBackgroundTertiary)
    }

    nonisolated func surfacePrimaryForeground() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    nonisolated func surfaceSecondaryForeground() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    nonisolated func surfaceTertiaryForeground() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    nonisolated func onSurfacePrimaryForeground() -> some View {
        foregroundColor(Color.onSurfacePrimary)
    }

    nonisolated func onSurfaceSecondaryForeground() -> some View {
        foregroundColor(Color.onSurfaceSecondary)
    }

    nonisolated func onSurfaceTertiaryForeground() -> some View {
        foregroundColor(Color.onSurfaceTertiary)
    }

    nonisolated func accentForeground() -> some View {
        foregroundColor(Color.accentColor)
    }

    nonisolated func errorForeground() -> some View {
        foregroundColor(Color.error)
    }

    nonisolated func successForeground() -> some View {
        foregroundColor(Color.success)
    }

    nonisolated func warningForeground() -> some View {
        foregroundColor(Color.warning)
    }

    nonisolated func linkForeground() -> some View {
        foregroundColor(Color.link)
    }

    nonisolated func borderForeground() -> some View {
        foregroundColor(Color.border)
    }
}

// MARK: - Fill Color Extension

public extension Shape {
    nonisolated func fillOnPrimary() -> some View {
        fill(Color.onPrimary)
    }

    nonisolated func fillOnPrimarySecondary() -> some View {
        fill(Color.onPrimarySecondary)
    }

    nonisolated func fillOnPrimaryTertiary() -> some View {
        fill(Color.onPrimaryTertiary)
    }

    nonisolated func fillAccent() -> some View {
        fill(Color.accentColor)
    }

    nonisolated func fillBackgroundPrimary() -> some View {
        fill(Color.backgroundPrimary)
    }

    nonisolated func fillBackgroundSecondary() -> some View {
        fill(Color.backgroundSecondary)
    }

    nonisolated func fillBackgroundTertiary() -> some View {
        fill(Color.backgroundTertiary)
    }

    nonisolated func fillOnBackgroundPrimary() -> some View {
        fill(Color.onBackgroundPrimary)
    }

    nonisolated func fillOnBackgroundSecondary() -> some View {
        fill(Color.onBackgroundSecondary)
    }

    nonisolated func fillOnBackgroundTertiary() -> some View {
        fill(Color.onBackgroundTertiary)
    }

    nonisolated func fillSurfacePrimary() -> some View {
        fill(Color.surfacePrimary)
    }

    nonisolated func fillSurfaceSecondary() -> some View {
        fill(Color.surfaceSecondary)
    }

    nonisolated func fillSurfaceTertiary() -> some View {
        fill(Color.surfaceTertiary)
    }

    nonisolated func fillOnSurfacePrimary() -> some View {
        fill(Color.onSurfacePrimary)
    }

    nonisolated func fillOnSurfaceSecondary() -> some View {
        fill(Color.onSurfaceSecondary)
    }

    nonisolated func fillOnSurfaceTertiary() -> some View {
        fill(Color.onSurfaceTertiary)
    }

    nonisolated func fillError() -> some View {
        fill(Color.error)
    }

    nonisolated func fillSuccess() -> some View {
        fill(Color.success)
    }

    nonisolated func fillWarning() -> some View {
        fill(Color.warning)
    }

    nonisolated func fillLink() -> some View {
        fill(Color.link)
    }

    nonisolated func fillBorder() -> some View {
        fill(Color.border)
    }
}

public extension View {
    @available(*, deprecated, renamed: "onPrimaryForeground")
    nonisolated func foregroundOnPrimaryHighEmphasis() -> some View {
        foregroundColor(Color.onPrimary)
    }

    @available(*, deprecated, renamed: "onPrimarySecondaryForeground")
    nonisolated func foregroundOnPrimaryMediumEmphasis() -> some View {
        foregroundColor(Color.onPrimarySecondary)
    }

    @available(*, deprecated, renamed: "onPrimaryTertiaryForeground")
    nonisolated func foregroundOnPrimaryDisabled() -> some View {
        foregroundColor(Color.onPrimaryTertiary)
    }

    @available(*, deprecated, renamed: "accentForeground")
    nonisolated func foregroundAccent() -> some View {
        foregroundColor(Color.accentColor)
    }

    @available(*, deprecated, renamed: "backgroundPrimary")
    nonisolated func foregroundBackgroundPrimary() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    @available(*, deprecated, renamed: "backgroundSecondaryForeground")
    nonisolated func foregroundBackgroundSecondary() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    @available(*, deprecated, renamed: "backgroundTertiaryForeground")
    nonisolated func foregroundBackgroundTertiary() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    @available(*, deprecated, renamed: "onBackgroundPrimaryForeground")
    nonisolated func foregroundOnBackgroundHighEmphasis() -> some View {
        foregroundColor(Color.onBackgroundPrimary)
    }

    @available(*, deprecated, renamed: "onBackgroundSecondaryForeground")
    nonisolated func foregroundOnBackgroundMediumEmphasis() -> some View {
        foregroundColor(Color.onBackgroundSecondary)
    }

    @available(*, deprecated, renamed: "onBackgroundTertiaryForeground")
    nonisolated func foregroundOnBackgroundDisabled() -> some View {
        foregroundColor(Color.onBackgroundTertiary)
    }

    @available(*, deprecated, renamed: "surfacePrimaryForeground")
    nonisolated func foregroundSurfacePrimary() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    @available(*, deprecated, renamed: "surfaceSecondaryForeground")
    nonisolated func foregroundSurfaceSecondary() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    @available(*, deprecated, renamed: "aurfaceTertiaryForegroundColor")
    nonisolated func foregroundSurfaceTertiary() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    @available(*, deprecated, renamed: "onSurfaceHighEmphasisForegroundColor")
    nonisolated func foregroundOnSurfaceHighEmphasis() -> some View {
        foregroundColor(Color.onSurfacePrimary)
    }

    @available(*, deprecated, renamed: "onSurfaceSecondaryForeground")
    nonisolated func foregroundOnSurfaceMediumEmphasis() -> some View {
        foregroundColor(Color.onSurfaceSecondary)
    }

    @available(*, deprecated, renamed: "onSurfaceTertiaryForeground")
    nonisolated func foregroundOnSurfaceDisabled() -> some View {
        foregroundColor(Color.onSurfaceTertiary)
    }

    @available(*, deprecated, renamed: "errorForeground")
    nonisolated func foregroundError() -> some View {
        foregroundColor(Color.error)
    }

    @available(*, deprecated, renamed: "successForeground")
    nonisolated func foregroundSuccess() -> some View {
        foregroundColor(Color.success)
    }

    @available(*, deprecated, renamed: "warningForeground")
    nonisolated func foregroundWarning() -> some View {
        foregroundColor(Color.warning)
    }

    @available(*, deprecated, renamed: "linkForeground")
    nonisolated func foregroundLink() -> some View {
        foregroundColor(Color.link)
    }

    @available(*, deprecated, renamed: "borderForeground")
    nonisolated func foregroundBorder() -> some View {
        foregroundColor(Color.border)
    }
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Accent")
                .foregroundColor(Color.onPrimarySecondary)
                .padding()

            HStack {
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(Color.onPrimary)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(Color.onPrimarySecondary)
                Rectangle().size(CGSize(width: 50, height: 50))
                    .foregroundColor(Color.onPrimaryTertiary)
                Rectangle().size(CGSize(width: 50, height: 50))
            }
            .padding(.horizontal)
        }
        .background(Color.accentColor)
        .padding()
    }
}
