//
// Copyright © 2022 Alexander Romanov
// PageView.swift
//

import SwiftUI


public struct PageView<Content, LeadingBar, TrailingBar, TopToolbar, TitleLabel>: View where Content: View, LeadingBar: View, TrailingBar: View, TopToolbar: View, TitleLabel: View {
    @Environment(\.screenSize) var screenSize
    
    private let title: String?
    private let content: Content
    private var isModalable = false
    private var isLargeTitle = false
    private var isAlwaysSlideSmallTile = false
    @State private var offset: CGPoint = .init(x: 0, y: 0)
    
    private var leadingBar: LeadingBar?
    private var trailingBar: TrailingBar?
    private var topToolbar: TopToolbar?
    private var titleLabel: TitleLabel?
    
    private var backgroundColor: Color = .backgroundPrimary
    private var backgroundLinerGradient: LinearGradient?
    
    private let onOffsetChanged: (CGFloat) -> Void
    
    public init(_ title: String? = nil,
                onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
                @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            if title != nil || leadingBar != nil || trailingBar != nil || topToolbar != nil || titleLabel != nil {
                ModalNavigationBar(title: title ?? "",
                                   bigTitle: isLargeTitle,
                                   offset: $offset,
                                   modalityPresent: !isModalable,
                                   alwaysSlideSmallTile: isAlwaysSlideSmallTile,
                                   leadingBar: { leadingBar },
                                   trailingBar: { trailingBar },
                                   bottomBar: { topToolbar },
                                   titleLabel: { titleLabel })
                .zIndex(999_999_999)
            }
            ScrollViewOffset(offset: $offset) {
                content
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(background.ignoresSafeArea())
        .onChange(of: offset) { offset in
            onOffsetChanged(offset.y)
        }
    }
    
    var background: some View {
        Group {
            if let backgroundLinerGradient {
                backgroundLinerGradient
            } else {
                backgroundColor
            }
        }
    }
    
    public func modalable(_ isModalable: Bool = true) -> PageView {
        var control = self
        control.isModalable = isModalable
        return control
    }
    
    public func slideSmallTile(_ isSlise: Bool = true) -> PageView {
        var control = self
        control.isAlwaysSlideSmallTile = isSlise
        return control
    }
    
    public func navigationBarHidden(_ isModalable: Bool = true) -> PageView {
        var control = self
        control.isModalable = isModalable
        return control
    }
    
    public func largeTitle(_ isLargeTitle: Bool = true) -> PageView {
        var control = self
        control.isLargeTitle = isLargeTitle
        return control
    }
    
    public func backgroundColor(_ backgroundColor: Color = .backgroundSecondary) -> PageView {
        var control = self
        control.backgroundColor = backgroundColor
        return control
    }
    
    public func backgroundSecondary() -> PageView {
        var control = self
        control.backgroundColor = .backgroundSecondary
        return control
    }
    
    public func backgroundLinerGradient(_ gradient: LinearGradient) -> PageView {
        var control = self
        control.backgroundLinerGradient = gradient
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
    
    public func titleLabel(@ViewBuilder titleLabel: @escaping () -> TitleLabel) -> PageView {
        var control = self
        control.titleLabel = titleLabel()
        return control
    }
    
    public func bottomToolbar(style: PageViewBottomType = .shadow, ignoreSafeArea: Bool = true, @ViewBuilder bottomToolbar: @escaping () -> some View) -> some View {
        VStack(spacing: .zero) {
            self
                .overlay(
                    Group {
                        if style == .gradient {
                            VStack {
                                Spacer()
                                LinearGradient(colors: [backgroundColor.opacity(0), Color.surfacePrimary.opacity(1)],
                                               startPoint: .top,
                                               endPoint: .bottom)
                                .frame(height: 60)
                            }
                        }
                        if style == .none {
                            VStack {
                                Spacer()
                                bottomToolbar()
                            }
                        }
                    })
            if style != .none {
                HStack {
                    Spacer()
                    bottomToolbar()
                    Spacer()
                }
                .background(Color.surfacePrimary.shadowElevaton(style == .shadow ? .z2 : .z0))
            }
        }
        .ignoresSafeArea(edges: ignoreSafeArea ? .bottom : .top)
    }
}

public extension PageView {
    enum PageViewBottomType {
        case shadow, gradient, none
    }
}

public extension PageView where LeadingBar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
        titleLabel = nil
    }
}

public extension PageView where TrailingBar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        trailingBar = nil
        titleLabel = nil
    }
}

public extension PageView where TrailingBar == EmptyView, LeadingBar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        titleLabel = nil
    }
}

public extension PageView where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
        titleLabel = nil
    }
}

public extension PageView where LeadingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
        topToolbar = nil
        titleLabel = nil
    }
}

public extension PageView where TrailingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        trailingBar = nil
        topToolbar = nil
        titleLabel = nil
    }
}

public extension PageView where TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        topToolbar = nil
        titleLabel = nil
    }
}

public extension PageView where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
    }
}

public extension PageView where TrailingBar == EmptyView, TopToolbar == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        trailingBar = nil
        topToolbar = nil
    }
}

public extension PageView where LeadingBar == EmptyView, TopToolbar == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
        topToolbar = nil
    }
}

public extension PageView where TrailingBar == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        trailingBar = nil
    }
}

public extension PageView where LeadingBar == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        leadingBar = nil
    }
}

public extension PageView where TopToolbar == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        topToolbar = nil
    }
}

