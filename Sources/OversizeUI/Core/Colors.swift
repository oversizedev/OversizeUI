//
// Copyright © 2022 Alexander Romanov
// Colors.swift
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

// MARK: - Foreground Color Extension

public extension View {
    func foregroundOnPrimaryHighEmphasis() -> some View {
        foregroundColor(Color.onPrimaryHighEmphasis)
    }

    func foregroundOnPrimaryMediumEmphasis() -> some View {
        foregroundColor(Color.onPrimaryMediumEmphasis)
    }

    func foregroundOnPrimaryDisabled() -> some View {
        foregroundColor(Color.onPrimaryDisabled)
    }

    func foregroundAccent() -> some View {
        foregroundColor(Color.accent)
    }

    func foregroundBackgroundPrimary() -> some View {
        foregroundColor(Color.backgroundPrimary)
    }

    func foregroundBackgroundSecondary() -> some View {
        foregroundColor(Color.backgroundSecondary)
    }

    func foregroundBackgroundTertiary() -> some View {
        foregroundColor(Color.backgroundTertiary)
    }

    func foregroundOnBackgroundHighEmphasis() -> some View {
        foregroundColor(Color.onBackgroundHighEmphasis)
    }

    func foregroundOnBackgroundMediumEmphasis() -> some View {
        foregroundColor(Color.onBackgroundMediumEmphasis)
    }

    func foregroundOnBackgroundDisabled() -> some View {
        foregroundColor(Color.onBackgroundDisabled)
    }

    func foregroundSurfacePrimary() -> some View {
        foregroundColor(Color.surfacePrimary)
    }

    func foregroundSurfaceSecondary() -> some View {
        foregroundColor(Color.surfaceSecondary)
    }

    func foregroundSurfaceTertiary() -> some View {
        foregroundColor(Color.surfaceTertiary)
    }

    func foregroundOnSurfaceHighEmphasis() -> some View {
        foregroundColor(Color.onSurfaceHighEmphasis)
    }

    func foregroundOnSurfaceMediumEmphasis() -> some View {
        foregroundColor(Color.onSurfaceMediumEmphasis)
    }

    func foregroundOnSurfaceDisabled() -> some View {
        foregroundColor(Color.onSurfaceDisabled)
    }

    func foregroundError() -> some View {
        foregroundColor(Color.error)
    }

    func foregroundSuccess() -> some View {
        foregroundColor(Color.success)
    }

    func foregroundWarning() -> some View {
        foregroundColor(Color.warning)
    }

    func foregroundLink() -> some View {
        foregroundColor(Color.link)
    }

    func foregroundBorder() -> some View {
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
        fill(Color.accent)
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
