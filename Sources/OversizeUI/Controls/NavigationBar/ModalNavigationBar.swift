//
// Copyright © 2022 Alexander Romanov
// ModalNavigationBar.swift
//

import SwiftUI

public struct ModalNavigationBar<LeadingBar: View, TrailingBar: View, BottomBar: View, TitleLabel: View>: View {
    private let leadingBar: () -> LeadingBar?
    private let trailingBar: () -> TrailingBar?
    private let bottomBar: () -> BottomBar?
    private let titleLabel: () -> TitleLabel?

    @Environment(\.screenSize) var screenSize

    private var title: String
    private var subtitle: String = ""
    private var bigTitle: Bool
    private let modalityPresent: Bool
    private let alwaysSlideSmallTile: Bool

    @Binding public var offset: CGPoint

    private var maxHeight: CGFloat = 100

    private let background: Color

    public init(title: String,
                bigTitle: Bool = true,
                offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
                background: Color = Color.backgroundPrimary,
                modalityPresent: Bool = true,
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
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
    }

    public var body: some View {
        ZStack(alignment: .top) {
            if bigTitle {
                VStack(alignment: .leading) {
                    Spacer()

                    HStack(spacing: .zero) {
                        Text(title)
                            .largeTitle()
                            .opacity(largeTitleOpacity)
                            .padding(.bottom, 8)
                        // .rotation3DEffect(.degrees(Double(offset.y)), axis: (x: 1, y: 0, z: 0))

                        titleLabel()

                        Spacer()
                    }
                }
                .frame(maxHeight: headerHeight)
                .padding(.leading, screenSize.safeAreaLeading)
                .padding(.trailing, screenSize.safeAreaTrailing)

                Rectangle()
                    .fill(Color.surfacePrimary)
                    .frame(maxWidth: .infinity, maxHeight: 60, alignment: .top)
                    .blur(radius: blurValue)
                    .offset(x: -20)
                    .opacity(smallBackgroundOpacity)
            }

            VStack(spacing: 20) {
                ZStack {
                    HStack {
                        leadingBar()

                        Spacer()
                    }

                    HStack(spacing: .zero) {
                        Spacer()

                        Text(title)
                            .title3()
                            .multilineTextAlignment(.center)
                            .frame(minHeight: 40)
                            .opacity(smallTitleOpacity)
                            .offset(y: -smmallTitleOffset)

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
        .padding(.top, modalityPresent ? screenSize.safeAreaTop + 20 : 20)
        .padding(.horizontal, 20)
        .padding(.bottom, bigTitle ? 0 : 20)
        .background(Color.surfacePrimary.opacity(smallBackgroundOpacity))
        .clipped()
        .shadow(color: Color.black.opacity(min(sadowOpacity, 0.08)),
                radius: max(offset.y * 0, 1, 8),
                x: 0,
                y: 2)
        #if os(iOS)
            .navigationBarHidden(true)
        #endif
    }

    private var smallTitleOpacity: Double {
        if bigTitle {
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

    private var sadowOpacity: Double {
        Double(offset.y * 0.001)
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
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
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.leadingBar = leadingBar
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder bottomBar: @escaping () -> BottomBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar,
         @ViewBuilder bottomBar: @escaping () -> BottomBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar,
         @ViewBuilder bottomBar: @escaping () -> BottomBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder bottomBar: @escaping () -> BottomBar,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder bottomBar: @escaping () -> BottomBar,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder leadingBar: @escaping () -> LeadingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
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
         offset: Binding<CGPoint> = .constant(CGPoint(x: 0, y: 0)),
         modalityPresent: Bool = true,
         alwaysSlideSmallTile: Bool = false,
         @ViewBuilder titleLabel: @escaping () -> TitleLabel,
         @ViewBuilder trailingBar: @escaping () -> TrailingBar)
    {
        self.title = title
        self.bigTitle = bigTitle
        self.background = background
        _offset = offset
        self.modalityPresent = modalityPresent
        self.alwaysSlideSmallTile = alwaysSlideSmallTile
        self.trailingBar = trailingBar
        leadingBar = { nil }
        bottomBar = { nil }
        self.titleLabel = titleLabel
    }
}
