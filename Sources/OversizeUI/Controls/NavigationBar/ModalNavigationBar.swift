//
// Copyright © 2021 Alexander Romanov
// ModalNavigationBar.swift, created 11.02.2021
//

import SwiftUI

public struct ModalNavigationBar<LeadingBar: View, TrailingBar: View, BottomBar: View, TitleLabel: View>: View {
    @Environment(\.screenSize) var screenSize
    @Binding public var offset: CGPoint

    private let leadingBar: () -> LeadingBar?
    private let trailingBar: () -> TrailingBar?
    private let bottomBar: () -> BottomBar?
    private let titleLabel: () -> TitleLabel?

    private var title: String
    private var bigTitle: Bool
    private let alwaysSlideSmallTile: Bool
    private let isDisableScrollShadow: Bool
    private let background: Color
    private var maxHeight: CGFloat = 100

    public init(title: String,
                bigTitle: Bool = true,
                isDisableScrollShadow: Bool = false,
                offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
                background: Color = Color.backgroundPrimary,
                alwaysSlideSmallTile: Bool = false,
                @ViewBuilder leadingBar: @escaping () -> LeadingBar,
                @ViewBuilder trailingBar: @escaping () -> TrailingBar,
                @ViewBuilder bottomBar: @escaping () -> BottomBar,
                @ViewBuilder titleLabel: @escaping () -> TitleLabel)
    {
        self.title = title
        self.bigTitle = bigTitle
        _offset = offset
        self.leadingBar = leadingBar
        self.trailingBar = trailingBar
        self.bottomBar = bottomBar
        self.titleLabel = titleLabel
        self.background = background
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
    }

    public var body: some View {
        ZStack(alignment: .top) {
            if bigTitle {
                bigTitleView

                Rectangle()
                    .fill(background)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .top)
                    .blur(radius: blurValue)
                    .offset(x: -20)
                    .opacity(min(smallBackgroundOpacity, 1))
                    .ignoresSafeArea(.all)
            }

            smallTitleView
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom, bigTitle ? 0 : 20)
        .background {
            Rectangle()
                .fill(background.opacity(min(smallBackgroundOpacity, 1)))
                .shadow(color: Color.black.opacity(min(shadowOpacity, 0.08)),
                        radius: max(offset.y * 0, 1, 8),
                        x: 0,
                        y: 2)
                .ignoresSafeArea()
        }
        #if os(iOS)
        .navigationBarHidden(true)
        #endif
    }

    private var smallTitleView: some View {
        VStack(spacing: 20) {
            ZStack {
                HStack {
                    leadingBar()

                    Spacer()
                }

                HStack(spacing: .zero) {
                    Spacer()

                    Text(title)
                        .title3(.semibold)
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 40)
                        .opacity(min(smallTitleOpacity, 1))
                        .offset(y: -smmallTitleOffset)
                    // .matchedGeometryEffect(id: "titleName", in: titleName, properties: .position, anchor: .center, isSource: true)

                    titleLabel()

                    Spacer()
                }

                HStack {
                    Spacer()

                    trailingBar()
                }
            }

            bottomBar()
        }
        .padding(.leading, screenSize.safeAreaLeading)
        .padding(.trailing, screenSize.safeAreaTrailing)
    }

    private var bigTitleView: some View {
        VStack(alignment: .leading) {
            Spacer()

            HStack(spacing: .zero) {
                Text(title)
                    .largeTitle()
                    .opacity(min(largeTitleOpacity, 1))
                    .padding(.bottom, 8)
                // .matchedGeometryEffect(id: "titleName", in: titleName,  properties: .position, anchor: .leading, isSource: true)

                titleLabel()

                Spacer()
            }
        }
        .frame(maxHeight: headerHeight)
        .padding(.leading, screenSize.safeAreaLeading)
        .padding(.trailing, screenSize.safeAreaTrailing)
    }

    private var smallTitleOpacity: Double {
        if alwaysSlideSmallTile || bigTitle {
            return Double((offset.y * 0.1) - 8)
        } else {
            return 1
        }
    }

    private var smallBackgroundOpacity: Double {
        if offset.y < 1 {
            return 0
        } else {
            return Double(offset.y * 0.1)
        }
    }

    private var shadowOpacity: Double {
        if isDisableScrollShadow {
            return 0
        } else {
            return Double(offset.y * 0.001)
        }
    }

    private var largeTitleOpacity: Double {
        if offset.y < 0 {
            return 1
        } else if offset.y > maxHeight {
            return 0
        } else {
            return Double(1 / (offset.y * 0.01))
        }
    }

    private var smmallTitleOffset: CGFloat {
        if bigTitle || alwaysSlideSmallTile {
            if offset.y < 50 {
                return -50
            } else if offset.y > 50 * 2 {
                return 0
            } else {
                return offset.y - (50 * 2)
            }
        } else {
            return 1
        }
    }

    private var blurValue: CGFloat {
        if offset.y < 1 {
            return 0
        } else if offset.y < 70 {
            return offset.y * 0.01
        } else {
            return 0
        }
    }

    private var headerHeight: CGFloat {
        if offset.y > 0 {
            let height = maxHeight - (offset.y / 2)
            return height > 0 ? height : 0
        } else {
            return maxHeight
        }
    }

    private var height: CGFloat {
        if offset.y < 86 {
            return 86
        } else if offset.y > maxHeight {
            return maxHeight
        } else {
            return offset.y
        }
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView,
    TrailingBar == EmptyView,
    BottomBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        leadingBar = { nil }
        trailingBar = { nil }
        bottomBar = { nil }
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    BottomBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.leadingBar = leadingBar
        self.trailingBar = trailingBar
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        bottomBar = { nil }
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    TrailingBar == EmptyView,
    BottomBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent _: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.leadingBar = leadingBar
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        trailingBar = { nil }
        bottomBar = { nil }
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView,
    BottomBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent _: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        leadingBar = { nil }
        self.trailingBar = trailingBar
        bottomBar = { nil }
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView,
    TrailingBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent _: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder bottomBar: @escaping () -> BottomBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        leadingBar = { nil }
        trailingBar = { nil }
        self.bottomBar = bottomBar
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar,
         @ViewBuilder bottomBar: @escaping () -> BottomBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        _offset = offset
        leadingBar = { nil }
        self.trailingBar = trailingBar
        self.bottomBar = bottomBar
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    TrailingBar == EmptyView,
    TitleLabel == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar,
         @ViewBuilder bottomBar: @escaping () -> BottomBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        _offset = offset
        self.leadingBar = leadingBar
        trailingBar = { nil }
        self.bottomBar = bottomBar
        titleLabel = { nil }
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView,
    TrailingBar == EmptyView,
    BottomBar == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        leadingBar = { nil }
        trailingBar = { nil }
        bottomBar = { nil }
        self.titleLabel = titleLabel
    }
}

public extension ModalNavigationBar
    where
    TrailingBar == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder bottomBar: @escaping () -> BottomBar,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        self.leadingBar = leadingBar
        trailingBar = { nil }
        self.bottomBar = bottomBar
        self.titleLabel = titleLabel
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder bottomBar: @escaping () -> BottomBar,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        self.trailingBar = trailingBar
        leadingBar = { nil }
        self.bottomBar = bottomBar
        self.titleLabel = titleLabel
    }
}

public extension ModalNavigationBar
    where
    TrailingBar == EmptyView,
    BottomBar == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        self.leadingBar = leadingBar
        trailingBar = { nil }
        bottomBar = { nil }
        self.titleLabel = titleLabel
    }
}

public extension ModalNavigationBar
    where
    LeadingBar == EmptyView,
    BottomBar == EmptyView
{
    init(title: String,
         bigTitle: Bool = true,
         background: Color = Color.backgroundPrimary,
         isDisableScrollShadow: Bool = false,
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.isDisableScrollShadow = isDisableScrollShadow
        self.trailingBar = trailingBar
        leadingBar = { nil }
        bottomBar = { nil }
        self.titleLabel = titleLabel
    }
}
