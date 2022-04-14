//
// Copyright © 2022 Alexander Romanov
// PageView.swift
//

import SwiftUI
public struct PageView<Label, LeadingBar, TrailingBar, TopToolbar>: View where Label: View, LeadingBar: View, TrailingBar: View, TopToolbar: View {
    @Environment(\.screenSize) var screenSize

    private let title: String?
    private let label: Label
    private var isModalable = false
    private var isLargeTitle = false
    @State private var offset: CGPoint = .init(x: 0, y: 0)

    private var leadingBar: LeadingBar?
    private var trailingBar: TrailingBar?
    private var topToolbar: TopToolbar?

    private var backgroundColor: Color = .backgroundPrimary

    public init(_ title: String? = nil,
                @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
    }

    public var body: some View {
        content
    }

    private var content: some View {
        VStack(spacing: .zero) {
            ModalNavigationBar(title: title ?? "",
                               bigTitle: isLargeTitle,
                               offset: $offset,
                               modalityPresent: !isModalable,
                               leadingBar: { leadingBar },
                               trailingBar: { trailingBar },
                               bottomBar: { topToolbar })
                .zIndex(999_999_999)
            ScrollViewOffset(offset: $offset) {
                label
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(backgroundColor.ignoresSafeArea())
    }

    public func modalable(_ isModalable: Bool = true) -> PageView {
        var control = self
        control.isModalable = isModalable
        return control
    }

    public func largeTitle(_ isLargeTitle: Bool = true) -> PageView {
        var control = self
        control.isLargeTitle = isLargeTitle
        return control
    }

    public func backgroundSecondary(_ backgroundColor: Color = .backgroundSecondary) -> PageView {
        var control = self
        control.backgroundColor = backgroundColor
        return control
    }

    public func leadingBar(@ViewBuilder leadingBar: @escaping () -> LeadingBar) -> PageView {
        var control = self
        control.leadingBar = leadingBar()
        return control
    }

    public func trailingBar(@ViewBuilder trailingBar: @escaping () -> TrailingBar) -> PageView {
        var control = self
        control.trailingBar = trailingBar()
        return control
    }

    public func topToolbar(@ViewBuilder topToolbar: @escaping () -> TopToolbar) -> PageView {
        var control = self
        control.topToolbar = topToolbar()
        return control
    }

    public func bottomToolbar<BottomToolbar: View>(@ViewBuilder bottomToolbar: @escaping () -> BottomToolbar) -> some View {
        VStack(spacing: .zero) {
            self
            HStack {
                Spacer()
                bottomToolbar()
                Spacer()
            }
            .paddingContent()
            .background(Color.surfacePrimary.shadowElevaton(.z2))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

public extension PageView where LeadingBar == EmptyView {
    init(_ title: String? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
        leadingBar = nil
    }
}

public extension PageView where TrailingBar == EmptyView {
    init(_ title: String? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
        trailingBar = nil
    }
}

public extension PageView where TrailingBar == EmptyView, LeadingBar == EmptyView {
    init(_ title: String? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
        leadingBar = nil
        trailingBar = nil
    }
}

public extension PageView where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView {
    init(_ title: String? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
    }
}

public extension PageView where LeadingBar == EmptyView, TopToolbar == EmptyView {
    init(_ title: String? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
        leadingBar = nil
        topToolbar = nil
    }
}

public extension PageView where TrailingBar == EmptyView, TopToolbar == EmptyView {
    init(_ title: String? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.title = title
        self.label = label()
        trailingBar = nil
        topToolbar = nil
    }
}
