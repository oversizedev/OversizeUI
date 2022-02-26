//
// Copyright © 2022 Alexander Romanov
// MaterialSurface.swift
//

import SwiftUI

public enum SurfaceMaterialTyps {
    /// A material that's somewhat translucent.
    case regular
    /// A material that's more opaque than translucent.
    case thick
    /// A material that's more translucent than opaque.
    case thin
    /// A mostly translucent material.
    case ultraThin
    /// A mostly opaque material.
    case ultraThick
}

public struct MaterialSurface<Label: View>: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.controlRadius) var controlRadius: Radius
    @Environment(\.controlPadding) var controlPadding: Space

    private let label: Label
    private let action: (() -> Void)?
    private var border: Color?
    private var material: SurfaceMaterialTyps = .regular

    public init(action: (() -> Void)? = nil,
                @ViewBuilder label: () -> Label)
    {
        self.label = label()
        self.action = action
    }

    public var body: some View {
        if action != nil {
            actionableSurface
        } else {
            surface
        }
    }

    private var actionableSurface: some View {
        Button {
            action?()
        } label: {
            surface
        }
        .buttonStyle(SurfaceButtonStyle())
    }

    @ViewBuilder
    private var surface: some View {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            label
                .padding(.all, controlPadding.rawValue)
                .background(backgroundMaterial, in: RoundedRectangle(cornerRadius: controlRadius.rawValue, style: .continuous))
                .overlay(overlayView)
                .shadowElevaton(elevation)
        } else {
            label
                .padding(.all, controlPadding.rawValue)
                .background(legacyBackgroundView)
                .overlay(overlayView)
                .shadowElevaton(elevation)
        }
    }

    @ViewBuilder
    private var overlayView: some View {
        RoundedRectangle(cornerRadius: controlRadius.rawValue, style: .continuous)
            .stroke(
                border != nil ? border ?? Color.clear
                    : theme.borderSurface
                    ? Color.border
                    : Color.clear, lineWidth: CGFloat(theme.borderSize)
            )
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var backgroundMaterial: Material {
        switch material {
        case .regular:
            return .regularMaterial
        case .thick:
            return .thickMaterial
        case .thin:
            return .thinMaterial
        case .ultraThin:
            return .ultraThinMaterial
        case .ultraThick:
            return .ultraThinMaterial
        }
    }

    private var legacyBackgroundViewColor: Color {
        switch material {
        case .ultraThin:
            return .surfacePrimary.opacity(0.15)
        case .thin:
            return .surfacePrimary.opacity(0.35)
        case .regular:
            return .surfacePrimary.opacity(0.5)
        case .thick:
            return .surfacePrimary.opacity(0.75)
        case .ultraThick:
            return .surfacePrimary.opacity(0.95)
        }
    }

    private var legacyBackgroundView: some View {
        RoundedRectangle(cornerRadius: controlRadius.rawValue,
                         style: .circular)
            .fill(legacyBackgroundViewColor)
    }

    public func surfaceStyle(_ material: SurfaceMaterialTyps) -> MaterialSurface {
        var control = self
        control.material = material
        return control
    }

    public func surfaceBorderColor(_ border: Color? = Color.border) -> MaterialSurface {
        var control = self
        control.border = border
        return control
    }
}
