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
    nonisolated func onPrimary() -> some View {
        foregroundColor(Color.onPrimary)
    }

    nonisolated func onPrimarySecondary() -> some View {
        foregroundColor(Color.onPrimarySecondary)
    }

    nonisolated func onPrimaryTertiary() -> some View {
        foregroundColor(Color.onPrimaryTertiary)
    }

    nonisolated func backgroundPrimary() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    nonisolated func backgroundSecondary() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    nonisolated func backgroundTertiary() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    nonisolated func onBackgroundPrimary() -> some View {
        foregroundColor(Color.onBackgroundPrimary)
    }

    nonisolated func onBackgroundSecondary() -> some View {
        foregroundColor(Color.onBackgroundSecondary)
    }

    nonisolated func onBackgroundTertiary() -> some View {
        foregroundColor(Color.onBackgroundTertiary)
    }

    nonisolated func surfacePrimary() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    nonisolated func surfaceSecondary() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    nonisolated func surfaceTertiary() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    nonisolated func onSurfacePrimary() -> some View {
        foregroundColor(Color.onSurfacePrimary)
    }

    nonisolated func onSurfaceSecondary() -> some View {
        foregroundColor(Color.onSurfaceSecondary)
    }

    nonisolated func onSurfaceTertiary() -> some View {
        foregroundColor(Color.onSurfaceTertiary)
    }

    nonisolated func accent() -> some View {
        foregroundColor(Color.accentColor)
    }

    nonisolated func error() -> some View {
        foregroundColor(Color.error)
    }

    nonisolated func success() -> some View {
        foregroundColor(Color.success)
    }

    nonisolated func warning() -> some View {
        foregroundColor(Color.warning)
    }

    nonisolated func link() -> some View {
        foregroundColor(Color.link)
    }

    nonisolated func border() -> some View {
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
