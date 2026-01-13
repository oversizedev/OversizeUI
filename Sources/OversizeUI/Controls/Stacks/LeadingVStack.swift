//
// Copyright © 2024 Alexander Romanov
// LeadingVStack.swift, created on 28.10.2024
//

import SwiftUI

public struct LeadingVStack<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            content
        }
    }
}

public struct TrailingVStack<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .trailing, spacing: spacing) {
            content
        }
    }
}

public struct CenterVStack<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .center, spacing: spacing) {
            content
        }
    }
}

public struct LeadingLazyVStack<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        LazyVStack(alignment: .leading, spacing: spacing) {
            content
        }
    }
}

public struct TrailingLazyVStack<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        LazyVStack(alignment: .trailing, spacing: spacing) {
            content
        }
    }
}

public struct CenterLazyVStack<Content: View>: View {
    private let spacing: CGFloat
    private let content: Content

    public init(spacing: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        LazyVStack(alignment: .center, spacing: spacing) {
            content
        }
    }
}
