//
// Copyright © 2021 Alexander Romanov
// PageIndexView.swift, created on 14.03.2024
//

import SwiftUI

@available(iOS 16.0, *)
public struct Page<Content, Header, LeadingBar, TrailingBar, TopToolbar, TitleLabel>: View
    where Content: View, Header: View, LeadingBar: View, TrailingBar: View, TopToolbar: View, TitleLabel: View
{
    @Environment(\.platform) var platform
    @Environment(\.screenSize) private var screenSize

    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    private let title: String?
    private let content: Content
    private var header: Header?
    private var leadingBar: LeadingBar?
    private var trailingBar: TrailingBar?
    private var topToolbar: TopToolbar?
    private var titleLabel: TitleLabel?

    private var isLargeTitle = false

    @State
    private var offset = CGPoint.zero

    private var visibleRatio: CGFloat {
        (calcHeaderHeight + offset.y) / calcHeaderHeight
    }

    @State
    private var isShowSearchBar = false

    private let onScroll: ScrollAction?

    let custumHeaderHeight: CGFloat

    @State
    private var navigationBarHeight: CGFloat = 0

    private let headerMinHeight: CGFloat?

    var calcHeaderHeight: CGFloat {
        isFocusSearchBar
            ? (navigationBarHeight - screenSize.safeAreaTop) + 20
            : (isLargeTitle && !isFocusSearchBar ? 60 : 0) + (isShowSearchBar ? 57 : 0) + custumHeaderHeight
    }

    /// Search
    @Binding private var searchQuery: String
    @Binding private var displaySearchBar: Bool
    @FocusState private var focusStateSearchBar: Bool
    @State private var isFocusSearchBar = false
    private var isEnableSearchBar = false
    private var prompt: String = .init()
    private var searchCancelButton: PageViewSearchButtonType = .icon
    @Namespace private var searchAnimation

    /// Background
    private var backgroundColor: Color = .backgroundPrimary
    private var backgroundLinerGradient: LinearGradient?

    public init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.onScroll = onScroll
        self.content = content()
        self.header = header()
        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }

    public var body: some View {
        ZStack(alignment: .top) {
            scrollView
            navbarOverlay
        }
        .onChange(of: focusStateSearchBar, perform: onChangeFocusSearchBar)
        .onChange(of: displaySearchBar, perform: onChangeDisplaySearchBar)
        #if os(iOS)
            .toolbar {
                if let title {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.headline)
                            .opacity(isLargeTitle ? 1 - visibleRatio : 1) // .opacity(isLargeTitle ? visibleRatio > 0 ? 0 : -5 * visibleRatio : 1)
                    }
                }
            }
            .toolbarBackground(.hidden)
            .toolbar(isFocusSearchBar ? .hidden : .automatic, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        #elseif os(macOS)
            .navigationTitle(title ?? "")
        #endif
    }

    var scrollView: some View {
        GeometryReader { proxy in
            ScrollViewWithOffsetTracking(showsIndicators: platform == .macOS, onScroll: handleOffset) {
                VStack(spacing: 0) {
                    scrollHeader
                        .opacity(isFocusSearchBar ? 0 : 1)
                    content
                        .frame(maxHeight: .infinity)
                }
            }
            .onAppear {
                if screenSize.safeAreaTop == 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        navigationBarHeight = proxy.safeAreaInsets.top
                    }
                } else {
                    DispatchQueue.main.async {
                        navigationBarHeight = proxy.safeAreaInsets.top
                    }
                }
            }
            .background(background.ignoresSafeArea())
        }
    }

    @ViewBuilder
    var scrollHeader: some View {
        ScrollViewHeader(content: pageHeader)
            .frame(height: calcHeaderHeight)
    }

    func handleOffset(_ scrollOffset: CGPoint) {
        offset = scrollOffset

        if isEnableSearchBar, scrollOffset.y > 95, !isShowSearchBar {
            withAnimation(.easeOut(duration: 0.30)) {
                isShowSearchBar = true
            }
        }
        onScroll?(offset, visibleRatio)
    }

    @ViewBuilder
    var navbarOverlay: some View {
        if isStickyHeaderVisible || isFocusSearchBar {
            Color.clear
                .frame(height: isFocusSearchBar ? navigationBarHeight + 20 : navigationBarHeight)
                .overlay(alignment: .bottom) {
                    if isFocusSearchBar {
                        searchHeader
                    } else {
                        scrollHeader
                    }
                }
                .ignoresSafeArea(edges: .top)
                .frame(height: headerMinHeight)
        }
    }

    func pageHeader() -> some View {
        ZStack(alignment: .bottomLeading) {
            if let header {
                header
            } else {
                Rectangle()
                    .fill(Color.surfacePrimary.opacity(visibleRatio > 0 ? 0 : -5 * visibleRatio))
                    // .fill(Material.bar.opacity(visibleRatio > 0 ? 0 : -5 * visibleRatio))
                    .overlay(alignment: .bottom) {
                        Divider().opacity(visibleRatio > 0 ? 0 : -5 * visibleRatio)
                    }
            }

            VStack(alignment: .leading, spacing: .xxSmall) {
                if isLargeTitle, !isFocusSearchBar, let title {
                    Text(title)
                        .largeTitle()
                        .opacity(visibleRatio)
                }

                if isEnableSearchBar, !isFocusSearchBar {
                    searchBarButton
                }
            }
            .padding(.horizontal, .medium)
        }
    }

    private var isStickyHeaderVisible: Bool {
        guard let headerMinHeight else { return visibleRatio <= 0 }
        return offset.y < -headerMinHeight
    }

    private var searchBarButton: some View {
        HStack(spacing: .zero) {
            Button {
                onChangeFocusSearchBar(true)
                displaySearchBar = true
                focusStateSearchBar = true
            } label: {
                Text(searchQuery.isEmpty ? "Search" : searchQuery)
            }
            .buttonStyle(SeartchTextFieldButtonStyle(height: isShowSearchBar ? 45 : min(max(offset.y / 2, 0), 45)))
            .matchedGeometryEffect(id: "PageSearchBar", in: searchAnimation)
        }
        .padding(.bottom, isShowSearchBar ? 12 : min(max(offset.y / 2, 0), 12))
        .opacity(isFocusSearchBar ? 1 : (isShowSearchBar ? visibleRatio : visibleRatio - 1))
    }

    private var searchHeader: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
            #if os(iOS) || os(macOS)
                .fill(Material.bar)
            #endif
                .overlay(alignment: .bottom) {
                    Divider().opacity(visibleRatio > 0 ? 0 : -5 * visibleRatio)
                }

            HStack(spacing: .zero) {
                TextField("Search", text: $searchQuery)
                    .textFieldStyle(SeartchTextFieldStyle())
                    .focused($focusStateSearchBar)
                    .submitLabel(.search)
                    .matchedGeometryEffect(id: "PageSearchBar", in: searchAnimation)

                if isFocusSearchBar {
                    Button("Cancel") {
                        focusStateSearchBar = false
                        displaySearchBar = false
                    }
                    .buttonStyle(.quaternary(infinityWidth: false))
                    #if !os(tvOS)
                        .controlSize(.mini)
                    #endif
                        .offset(x: 8)
                }
            }
            .padding(.horizontal, .small)
            .padding(.bottom, 12)
        }
    }

    public enum PageViewSearchButtonType {
        case none, icon, label(String = "Cancel")
    }

    public func largeTitle(_ isLargeTitle: Bool = true) -> Page {
        var control = self
        control.isLargeTitle = isLargeTitle
        return control
    }

    private var searchCancelButtonPadding: Space {
        switch searchCancelButton {
        case .icon, .none:
            .xSmall
        case .label:
            .xxSmall
        }
    }

    @ViewBuilder
    private var searchCancelButtonView: some View {
        switch searchCancelButton {
        case .none:
            EmptyView()
        case .icon:
            IconDeprecated(.xMini, color: .onSurfaceSecondary)
                .background {
                    Circle()
                        .fill(Color.backgroundTertiary)
                        .frame(width: 36, height: 36)
                }
        case let .label(text):
            Text(text)
                .subheadline(.bold)
                .foregroundColor(.onSurfacePrimary)
                .padding(.horizontal, .xSmall)
                .background {
                    RoundedRectangle(cornerRadius: .small, style: .continuous)
                        .fill(Color.backgroundTertiary)
                        .frame(height: 40)
                }
        }
    }

    func onChangeFocusSearchBar(_ state: Bool) {
        withAnimation(.easeIn(duration: 0.20)) {
            isFocusSearchBar = state
        }
    }

    func onChangeDisplaySearchBar(_ state: Bool) {
        onChangeFocusSearchBar(state)
        focusStateSearchBar = state
    }

    public func searchable(text: Binding<String>, prompt: String = "Search", cancelButton: Page.PageViewSearchButtonType = .label(), isSearch: Binding<Bool>) -> Page {
        var control = self
        control._searchQuery = text
        control._displaySearchBar = isSearch
        control.prompt = prompt
        control.isEnableSearchBar = true
        control.searchCancelButton = cancelButton
        return control
    }

    public func searchable(text: Binding<String>, prompt: String = "Search") -> Page {
        var control = self
        control._searchQuery = text
        control._displaySearchBar = .constant(true)
        control.prompt = prompt
        control.isShowSearchBar = true
        control.searchCancelButton = .none
        return control
    }

    public func leadingBar(@ViewBuilder leadingBar: @escaping () -> LeadingBar) -> Page {
        var control = self
        control.leadingBar = leadingBar()
        return control
    }

    public func trailingBar(@ViewBuilder trailingBar: @escaping () -> TrailingBar) -> Page {
        var control = self
        control.trailingBar = trailingBar()
        return control
    }

    public func topToolbar(@ViewBuilder topToolbar: @escaping () -> TopToolbar) -> Page {
        var control = self
        control.topToolbar = topToolbar()
        return control
    }

    public func titleLabel(@ViewBuilder titleLabel: @escaping () -> TitleLabel) -> Page {
        var control = self
        control.titleLabel = titleLabel()
        return control
    }

    public func bottomToolbar(style: PageViewBottomType = .shadow, @ViewBuilder bottomToolbar: @escaping () -> some View) -> some View {
        VStack(spacing: .zero) {
            overlay(
                Group {
                    if style == .gradient {
                        VStack {
                            Spacer()
                            LinearGradient(
                                colors: [backgroundColor.opacity(0), Color.surfacePrimary.opacity(1)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
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
    }
}

@available(iOS 16.0, *)
public extension Page {
    enum PageViewBottomType {
        case shadow, gradient, none
    }
}

@available(iOS 16.0, *)
public extension Page {
    @ViewBuilder
    internal var background: some View {
        if let backgroundLinerGradient {
            backgroundLinerGradient
        } else {
            backgroundColor
        }
    }

    func backgroundColor(_ backgroundColor: Color = .backgroundSecondary) -> Page {
        var control = self
        control.backgroundColor = backgroundColor
        return control
    }

    func backgroundSecondary() -> Page {
        var control = self
        control.backgroundColor = .backgroundSecondary
        return control
    }

    func backgroundLinerGradient(_ gradient: LinearGradient) -> Page {
        var control = self
        control.backgroundLinerGradient = gradient
        return control
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, LeadingBar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        topToolbar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        topToolbar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TopToolbar == EmptyView, TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        topToolbar = nil
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, TopToolbar == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        topToolbar = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, TopToolbar == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        topToolbar = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TopToolbar == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        topToolbar = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TitleLabel == EmptyView, Header == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        titleLabel = nil
        header = nil

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, LeadingBar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        topToolbar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        topToolbar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TopToolbar == EmptyView, TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        topToolbar = nil
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, LeadingBar == EmptyView, TopToolbar == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        trailingBar = nil
        topToolbar = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView, TopToolbar == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        topToolbar = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView, TopToolbar == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        topToolbar = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TrailingBar == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        trailingBar = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where LeadingBar == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        leadingBar = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TopToolbar == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        topToolbar = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

@available(iOS 16.0, *)
public extension Page where TitleLabel == EmptyView {
    init(
        _ title: String? = nil,
        headerHeight: CGFloat = 0,
        headerMinHeight: CGFloat? = nil,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> Header
    ) {
        self.title = title
        self.onScroll = onScroll
        custumHeaderHeight = headerHeight
        self.headerMinHeight = headerMinHeight
        self.content = content()
        titleLabel = nil
        self.header = header()

        _searchQuery = .constant(.init())
        _displaySearchBar = .constant(false)
    }
}

struct SeartchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(spacing: .xxSmall) {
            Image.Base.search
                .renderingMode(.template)
                .onSurfaceTertiaryForeground()

            configuration
        }
        .onSurfacePrimaryForeground()
        .callout(.semibold)
        .padding(.horizontal, 12)
        .padding(.vertical, .xSmall)
        .background(
            RoundedRectangle(
                cornerRadius: .medium,
                style: .continuous
            )
            .fill(Color.onSurfacePrimary.opacity(0.07))
        )
        .submitLabel(.search)
    }
}

struct SeartchTextFieldButtonStyle: ButtonStyle {
    let height: CGFloat

    init(height: CGFloat = 45) {
        self.height = height
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        let opacity = ((height - 20) * 4) * 0.01

        HStack(spacing: .xxSmall) {
            Image.Base.search
                .renderingMode(.template)
                .foregroundColor(Color.onSurfaceTertiary.opacity(height > 20 ? opacity : 0))

            configuration.label
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.onSurfaceTertiary.opacity(height > 20 ? opacity : 0))
        }
        .callout(.semibold)
        .padding(.horizontal, 12)
        .frame(height: height)
        .background(
            RoundedRectangle(
                cornerRadius: .medium,
                style: .continuous
            )
            .fill(Color.onSurfacePrimary.opacity(0.07))
        )
        .submitLabel(.search)
    }
}
