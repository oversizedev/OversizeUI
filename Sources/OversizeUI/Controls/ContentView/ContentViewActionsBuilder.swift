//
// Copyright © 2025 Alexander Romanov
// LayoutButtonBuilder.swift, created on 07.08.2025
//

import SwiftUI

@resultBuilder
public struct ContentViewActionsBuilder {
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }

    @MainActor
    public static func buildBlock(_ v1: some View) -> some View {
        v1.buttonStyle(.primary(infinityWidth: true))
            .accent()
    }

    @MainActor
    public static func buildBlock(_ v1: some View, _ v2: some View) -> some View {
        VStack(spacing: .small) {
            v1.buttonStyle(.primary(infinityWidth: true))
                .accent()
            v2.buttonStyle(.secondary(infinityWidth: true))
                .accent()
        }
    }

    @MainActor
    public static func buildBlock(_ v1: some View, _ v2: some View, _ v3: some View) -> some View {
        VStack(spacing: .small) {
            v1.buttonStyle(.primary(infinityWidth: true))
                .accent()
            v2.buttonStyle(.secondary(infinityWidth: true))
                .accent()
            v3.buttonStyle(.tertiary(infinityWidth: true))
                .accent()
        }
    }

    @MainActor
    public static func buildEither(first component: some View) -> some View {
        component
    }

    @MainActor
    public static func buildEither(second component: some View) -> some View {
        component
    }

    public static func buildOptional<Content>(_ content: Content?) -> Content? where Content: View {
        content
    }

    public static func buildIf<Content>(_ content: Content?) -> Content? where Content: View {
        content
    }
}
