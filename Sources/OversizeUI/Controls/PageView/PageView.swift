//
// Copyright © 2021 Alexander Romanov
// PageView.swift, created on 14.04.2022
//

import SwiftUI

public struct PageView<Content, LeadingBar, TrailingBar, TopToolbar, TitleLabel>: View where Content: View, LeadingBar: View, TrailingBar: View, TopToolbar: View, TitleLabel: View {
    @Environment(\.screenSize) var screenSize

    private let title: String?
    private let content: Content
    private var isLargeTitle = false
    private var isAlwaysSlideSmallTile = false
    private var isDisableScrollShadow: Bool = false
    @State private var offset: CGPoint = .init(x: 0, y: 0)

    private var leadingBar: LeadingBar?
    private var trailingBar: TrailingBar?
    private var topToolbar: TopToolbar?
    private var titleLabel: TitleLabel?

    private var backgroundColor: Color = .backgroundPrimary
    private var backgroundLinerGradient: LinearGradient?
    private var navigationBarDividerColor: Color?

    @Binding private var searchQuery: String
    @Binding private var displaySearchBar: Bool
    private var isShowSearchBar: Bool = false
    private var searchCancelButton: PageViewSearchButtonType = .icon
    private var prompt: String = .init()

    private let onOffsetChanged: (CGFloat) -> Void

    public init(_ title: String? = nil,
                onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
                @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }

    public var body: some View {
        ScrollViewOffset(offset: $offset) {
            content
        }
        .background(background.ignoresSafeArea())
        .safeAreaInset(edge: .top) { header }
        .onChange(of: offset) { offset in
            if isShowSearchBar, offset.y < -60 {
                withAnimation(.easeIn(duration: 0.2)) {
                    displaySearchBar = true
                }
            }
        }
    }

    @ViewBuilder
    var header: some View {
        if title != nil || leadingBar != nil || trailingBar != nil || topToolbar != nil || titleLabel != nil {
            ModalNavigationBar(
                title: title ?? "",
                bigTitle: displaySearchBar ? false : isLargeTitle,
                isDisableScrollShadow: isDisableScrollShadow,
                offset: $offset,
                background: isDisableScrollShadow ? backgroundColor : Color.surfacePrimary,
                alwaysSlideSmallTile: isAlwaysSlideSmallTile,
                leadingBar: { leadingBar },
                trailingBar: { trailingBar },
                bottomBar: { bottomToolBar },
                titleLabel: { titleLabel }
            )
            .overlay(alignment: .bottom) {
                if let navigationBarDividerColor {
                    Rectangle()
                        .fill(navigationBarDividerColor)
                        .frame(height: 1)
                        .offset(y: 1)
                }
            }
            .ignoresSafeArea(edges: .horizontal)
        }
    }

    @ViewBuilder
    var bottomToolBar: some View {
        if displaySearchBar {
            TextField(prompt, text: $searchQuery)
                .textFieldStyle(.default)
                .submitLabel(.search)
                .overlay(alignment: .trailing) {
                    Button {
                        searchQuery = ""
                        withAnimation(.easeInOut(duration: 0.15)) {
                            displaySearchBar = false
                        }
                    } label: {
                        searchCancelButtonView
                    }
                    .buttonStyle(.scale)
                    .padding(.trailing, searchCancelButtonPadding)
                }
        } else {
            topToolbar
        }
    }

    var searchCancelButtonPadding: Space {
        switch searchCancelButton {
        case .icon, .none:
            return .small
        case .label:
            return .xxSmall
        }
    }

    @ViewBuilder
    var searchCancelButtonView: some View {
        switch searchCancelButton {
        case .none:
            EmptyView()
        case .icon:
            Icon(.xMini, color: .onSurfaceMediumEmphasis)
                .background {
                    Circle()
                        .fill(Color.backgroundTertiary)
                        .frame(width: 36, height: 36)
                }
        case let .label(text):
            Text(text)
                .subheadline(.bold)
                .foregroundColor(.onSurfaceHighEmphasis)
                .padding(.horizontal, .xSmall)
                .background {
                    RoundedRectangle(cornerRadius: .small, style: .continuous)
                        .fill(Color.backgroundTertiary)
                        .frame(height: 40)
                }
        }
    }

    @ViewBuilder
    var background: some View {
        if let backgroundLinerGradient {
            backgroundLinerGradient
        } else {
            backgroundColor
        }
    }

    public func searchable(text: Binding<String>, prompt: String = "Search", cancelButton: PageView.PageViewSearchButtonType = .label(), isSearch: Binding<Bool>) -> PageView {
        var control = self
        control._searchQuery = text
        control._displaySearchBar = isSearch
        control.prompt = prompt
        control.isShowSearchBar = true
        control.searchCancelButton = cancelButton
        return control
    }

    public func searchable(text: Binding<String>, prompt: String = "Search") -> PageView {
        var control = self
        control._searchQuery = text
        control._displaySearchBar = .constant(true)
        control.prompt = prompt
        control.isShowSearchBar = true
        control.searchCancelButton = .none
        return control
    }

    public func disableScrollShadow(_ isDisableScrollShadow: Bool = true) -> PageView {
        var control = self
        control.isDisableScrollShadow = isDisableScrollShadow
        return control
    }

    public func slideSmallTile(_ isSlise: Bool = true) -> PageView {
        var control = self
        control.isAlwaysSlideSmallTile = isSlise
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

    public func navigationBarDividerColor(_ color: Color) -> PageView {
        var control = self
        control.navigationBarDividerColor = color
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

    enum PageViewSearchButtonType {
        case none, icon, label(String = "Cancel")
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
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
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

public extension PageView where TitleLabel == EmptyView {
    init(_ title: String? = nil,
         onOffsetChanged: @escaping (CGFloat) -> Void = { _ in },
         @ViewBuilder content: () -> Content)
    {
        self.title = title
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
        titleLabel = nil
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}
