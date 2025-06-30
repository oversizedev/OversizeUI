//
// Copyright © 2021 Alexander Romanov
// MaterialSurface.swift, created on 26.02.2023
//

import SwiftUI

#if os(iOS)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public struct MaterialSurface<Label: View>: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.controlRadius) var controlRadius: Radius
    @Environment(\.surfaceContentMargins) var controlPadding: EdgeSpaceInsets

    private let label: Label
    private let action: (() -> Void)?
    private var border: Color?
    private var material: Material = .regular

    public init(
        action: (() -> Void)? = nil,
        @ViewBuilder label: () -> Label
    ) {
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
        label
            .padding(
                EdgeSpaceInsets(top: controlPadding.top, leading: controlPadding.leading, bottom: controlPadding.bottom, trailing: controlPadding.trailing)
            )
            .background(
                material,
                in: RoundedRectangle(cornerRadius: controlRadius, style: .continuous)
            )
            .overlay(overlayView)
            .shadowElevation(elevation)
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

    public func surfaceStyle(_ material: Material) -> MaterialSurface {
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
#endif
