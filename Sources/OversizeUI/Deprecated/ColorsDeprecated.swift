//
// Copyright © 2021 Alexander Romanov
// Colors.swift, created on 11.09.2021
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "onPrimary")
    nonisolated func onPrimaryForeground() -> some View {
        foregroundColor(Color.onPrimary)
    }

    @available(*, deprecated, renamed: "onPrimarySecondary")
    nonisolated func onPrimarySecondaryForeground() -> some View {
        foregroundColor(Color.onPrimarySecondary)
    }

    @available(*, deprecated, renamed: "onPrimaryTertiary")
    nonisolated func onPrimaryTertiaryForeground() -> some View {
        foregroundColor(Color.onPrimaryTertiary)
    }

    @available(*, deprecated, renamed: "backgroundSecondary")
    nonisolated func backgroundSecondaryForeground() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    @available(*, deprecated, renamed: "backgroundTertiary")
    nonisolated func backgroundTertiaryForeground() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    @available(*, deprecated, renamed: "onBackgroundPrimary")
    nonisolated func onBackgroundPrimaryForeground() -> some View {
        foregroundColor(Color.onBackgroundPrimary)
    }

    @available(*, deprecated, renamed: "onBackgroundSecondary")
    nonisolated func onBackgroundSecondaryForeground() -> some View {
        foregroundColor(Color.onBackgroundSecondary)
    }

    @available(*, deprecated, renamed: "onBackgroundTertiary")
    nonisolated func onBackgroundTertiaryForeground() -> some View {
        foregroundColor(Color.onBackgroundTertiary)
    }

    @available(*, deprecated, renamed: "surfacePrimary")
    nonisolated func surfacePrimaryForeground() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    @available(*, deprecated, renamed: "surfaceSecondary")
    nonisolated func surfaceSecondaryForeground() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    @available(*, deprecated, renamed: "surfaceTertiary")
    nonisolated func surfaceTertiaryForeground() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    @available(*, deprecated, renamed: "onSurfacePrimary")
    nonisolated func onSurfacePrimaryForeground() -> some View {
        foregroundColor(Color.onSurfacePrimary)
    }

    @available(*, deprecated, renamed: "onSurfaceSecondary")
    nonisolated func onSurfaceSecondaryForeground() -> some View {
        foregroundColor(Color.onSurfaceSecondary)
    }

    @available(*, deprecated, renamed: "onSurfaceTertiary")
    nonisolated func onSurfaceTertiaryForeground() -> some View {
        foregroundColor(Color.onSurfaceTertiary)
    }

    @available(*, deprecated, renamed: "accent")
    nonisolated func accentForeground() -> some View {
        foregroundColor(Color.accentColor)
    }

    @available(*, deprecated, renamed: "error")
    nonisolated func errorForeground() -> some View {
        foregroundColor(Color.error)
    }

    @available(*, deprecated, renamed: "success")
    nonisolated func successForeground() -> some View {
        foregroundColor(Color.success)
    }

    @available(*, deprecated, renamed: "warning")
    nonisolated func warningForeground() -> some View {
        foregroundColor(Color.warning)
    }

    @available(*, deprecated, renamed: "link")
    nonisolated func linkForeground() -> some View {
        foregroundColor(Color.link)
    }

    @available(*, deprecated, renamed: "border")
    nonisolated func borderForeground() -> some View {
        foregroundColor(Color.border)
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
