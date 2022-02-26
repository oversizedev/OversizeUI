//
// Copyright © 2022 Alexander Romanov
// Background.swift
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
        static var paddingM: CGFloat { Space.medium.rawValue }
        static var paddingS: CGFloat { Space.small.rawValue }

        /// Radius
        static var radiusM: CGFloat { Radius.medium.rawValue }
        static var radiusS: CGFloat { Radius.small.rawValue }
    }

    private let content: Content
    private let background: BackgroundColor
    public var padding: BackgroundPadding

    public init(background: BackgroundColor = .primary,
                padding: BackgroundPadding = .medium,
                @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.padding = padding
        self.background = background
    }

    public var body: some View {
        self.content
            .padding(.all, paddingSize)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(Radius.medium)
    }

    private var paddingSize: CGFloat {
        switch padding {
        case .medium:
            return Constants.paddingM
        case .small:
            return Constants.paddingS
        }
    }

    private var backgroundColor: Color {
        switch background {
        case .primary:
            return Constants.colorPrimary
        case .secondary:
            return Constants.colorSecondary
        case .tertiary:
            return Constants.colorTertiary
        }
    }
}
