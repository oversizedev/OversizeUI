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
    nonisolated func onPrimaryHighEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onPrimaryHighEmphasis)
    }

    nonisolated func onPrimaryMediumEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onPrimaryMediumEmphasis)
    }

    nonisolated func onPrimaryDisabledForegroundColor() -> some View {
        foregroundColor(Color.onPrimaryDisabled)
    }

    nonisolated func backgroundPrimaryForegroundColor() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    nonisolated func backgroundSecondaryForegroundColor() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    nonisolated func backgroundTertiaryForegroundColor() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    nonisolated func onBackgroundHighEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onBackgroundHighEmphasis)
    }

    nonisolated func onBackgroundMediumEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onBackgroundMediumEmphasis)
    }

    nonisolated func onBackgroundDisabledForegroundColor() -> some View {
        foregroundColor(Color.onBackgroundDisabled)
    }

    nonisolated func surfacePrimaryForegroundColor() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    nonisolated func surfaceSecondaryForegroundColor() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    nonisolated func surfaceTertiaryForegroundColor() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    nonisolated func onSurfaceHighEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onSurfaceHighEmphasis)
    }

    nonisolated func onSurfaceMediumEmphasisForegroundColor() -> some View {
        foregroundColor(Color.onSurfaceMediumEmphasis)
    }

    nonisolated func onSurfaceDisabledForegroundColor() -> some View {
        foregroundColor(Color.onSurfaceDisabled)
    }

    nonisolated func accentForegroundColor() -> some View {
        foregroundColor(Color.accentColor)
    }

    nonisolated func errorForegroundColor() -> some View {
        foregroundColor(Color.error)
    }

    nonisolated func successForegroundColor() -> some View {
        foregroundColor(Color.success)
    }

    nonisolated func warningForegroundColor() -> some View {
        foregroundColor(Color.warning)
    }

    nonisolated func linkForegroundColor() -> some View {
        foregroundColor(Color.link)
    }

    nonisolated func borderForegroundColor() -> some View {
        foregroundColor(Color.border)
    }
}

// MARK: - Fill Color Extension

public extension Shape {
    nonisolated func fillOnPrimaryHighEmphasis() -> some View {
        fill(Color.onPrimaryHighEmphasis)
    }

    nonisolated func fillOnPrimaryMediumEmphasis() -> some View {
        fill(Color.onPrimaryMediumEmphasis)
    }

    nonisolated func fillOnPrimaryDisabled() -> some View {
        fill(Color.onPrimaryDisabled)
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

    nonisolated func fillOnBackgroundHighEmphasis() -> some View {
        fill(Color.onBackgroundHighEmphasis)
    }

    nonisolated func fillOnBackgroundMediumEmphasis() -> some View {
        fill(Color.onBackgroundMediumEmphasis)
    }

    nonisolated func fillOnBackgroundDisabled() -> some View {
        fill(Color.onBackgroundDisabled)
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

    nonisolated func fillOnSurfaceHighEmphasis() -> some View {
        fill(Color.onSurfaceHighEmphasis)
    }

    nonisolated func fillOnSurfaceMediumEmphasis() -> some View {
        fill(Color.onSurfaceMediumEmphasis)
    }

    nonisolated func fillOnSurfaceDisabled() -> some View {
        fill(Color.onSurfaceDisabled)
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
    @available(*, deprecated, renamed: "onPrimaryHighEmphasisForegroundColor")
    nonisolated func foregroundOnPrimaryHighEmphasis() -> some View {
        foregroundColor(Color.onPrimaryHighEmphasis)
    }

    @available(*, deprecated, renamed: "onPrimaryMediumEmphasisForegroundColor")
    nonisolated func foregroundOnPrimaryMediumEmphasis() -> some View {
        foregroundColor(Color.onPrimaryMediumEmphasis)
    }

    @available(*, deprecated, renamed: "onPrimaryDisabledForegroundColor")
    nonisolated func foregroundOnPrimaryDisabled() -> some View {
        foregroundColor(Color.onPrimaryDisabled)
    }

    @available(*, deprecated, renamed: "accentForegroundColor")
    nonisolated func foregroundAccent() -> some View {
        foregroundColor(Color.accentColor)
    }

    @available(*, deprecated, renamed: "backgroundPrimaryForegroundColor")
    nonisolated func foregroundBackgroundPrimary() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    @available(*, deprecated, renamed: "backgroundSecondaryForegroundColor")
    nonisolated func foregroundBackgroundSecondary() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    @available(*, deprecated, renamed: "backgroundTertiaryForegroundColor")
    nonisolated func foregroundBackgroundTertiary() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    @available(*, deprecated, renamed: "onBackgroundHighEmphasisForegroundColor")
    nonisolated func foregroundOnBackgroundHighEmphasis() -> some View {
        foregroundColor(Color.onBackgroundHighEmphasis)
    }

    @available(*, deprecated, renamed: "onBackgroundMediumEmphasisForegroundColor")
    nonisolated func foregroundOnBackgroundMediumEmphasis() -> some View {
        foregroundColor(Color.onBackgroundMediumEmphasis)
    }

    @available(*, deprecated, renamed: "onBackgroundDisabledForegroundColor")
    nonisolated func foregroundOnBackgroundDisabled() -> some View {
        foregroundColor(Color.onBackgroundDisabled)
    }

    @available(*, deprecated, renamed: "surfacePrimaryForegroundColor")
    nonisolated func foregroundSurfacePrimary() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    @available(*, deprecated, renamed: "surfaceSecondaryForegroundColor")
    nonisolated func foregroundSurfaceSecondary() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    @available(*, deprecated, renamed: "aurfaceTertiaryForegroundColor")
    nonisolated func foregroundSurfaceTertiary() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    @available(*, deprecated, renamed: "onSurfaceHighEmphasisForegroundColor")
    nonisolated func foregroundOnSurfaceHighEmphasis() -> some View {
        foregroundColor(Color.onSurfaceHighEmphasis)
    }

    @available(*, deprecated, renamed: "onSurfaceMediumEmphasisForegroundColor")
    nonisolated func foregroundOnSurfaceMediumEmphasis() -> some View {
        foregroundColor(Color.onSurfaceMediumEmphasis)
    }

    @available(*, deprecated, renamed: "onSurfaceDisabledForegroundColor")
    nonisolated func foregroundOnSurfaceDisabled() -> some View {
        foregroundColor(Color.onSurfaceDisabled)
    }

    @available(*, deprecated, renamed: "errorForegroundColor")
    nonisolated func foregroundError() -> some View {
        foregroundColor(Color.error)
    }

    @available(*, deprecated, renamed: "successForegroundColor")
    nonisolated func foregroundSuccess() -> some View {
        foregroundColor(Color.success)
    }

    @available(*, deprecated, renamed: "warningForegroundColor")
    nonisolated func foregroundWarning() -> some View {
        foregroundColor(Color.warning)
    }

    @available(*, deprecated, renamed: "linkForegroundColor")
    nonisolated func foregroundLink() -> some View {
        foregroundColor(Color.link)
    }

    @available(*, deprecated, renamed: "borderForegroundColor")
    nonisolated func foregroundBorder() -> some View {
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
