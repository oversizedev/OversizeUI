//
// Copyright © 2021 Alexander Romanov
// Background.swift, created on 07.06.2020
//

import SwiftUI

public enum BackgroundColor: Int, CaseIterable {
    case primary
    case secondary
    case tertiary
}

public enum BackgroundPadding: Int, CaseIterable {
    case medium
    case small
}

// swiftlint:disable opening_brace
public struct Background<Content: View>: View {
    private enum Constants {
        /// Colors
        static var colorPrimary: Color { Color.backgroundPrimary }
        static var colorSecondary: Color { Color.backgroundSecondary }
        static var colorTertiary: Color { Color.backgroundTertiary }

        /// Size
        static var paddingMedium: CGFloat { Space.medium.rawValue }
        static var paddingSmall: CGFloat { Space.small.rawValue }
    }

    private let content: Content
    private let background: BackgroundColor
    public var padding: BackgroundPadding

    public init(
        background: BackgroundColor = .primary,
        padding: BackgroundPadding = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.padding = padding
        self.background = background
    }

    public var body: some View {
        content
            .padding(.all, paddingSize)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(Radius.medium)
    }

    private var paddingSize: CGFloat {
        switch padding {
        case .medium:
            Constants.paddingMedium
        case .small:
            Constants.paddingSmall
        }
    }

    private var backgroundColor: Color {
        switch background {
        case .primary:
            Constants.colorPrimary
        case .secondary:
            Constants.colorSecondary
        case .tertiary:
            Constants.colorTertiary
        }
    }
}
