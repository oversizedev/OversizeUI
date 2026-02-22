//
// Copyright © 2025 Alexander Romanov
// ToolbarLabelStyle.swift, created on 18.08.2025
//

import SwiftUI

public struct ToolbarLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            Label(configuration)
        } else {
            Label(configuration)
                .labelStyle(.titleOnly)
        }
    }
}

public extension LabelStyle where Self == ToolbarLabelStyle {
    static var toolbar: Self {
        .init()
    }
}

public struct ToolbarProminentStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            Button(configuration)
                .buttonStyle(.glassProminent)
        } else {
            Button(configuration)
        }
    }
}

public struct ToolbarSecondaryStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            Button(configuration)
                .tint(Color.onSurfacePrimary)
        } else {
            Button(configuration)
        }
    }
}

public extension PrimitiveButtonStyle where Self == ToolbarProminentStyle {
    static var toolbarPrimary: Self {
        .init()
    }
}

public extension PrimitiveButtonStyle where Self == ToolbarSecondaryStyle {
    static var toolbarSecondary: Self {
        .init()
    }
}
