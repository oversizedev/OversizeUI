//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
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

    public var backgroundColor: Color = Constants.colorPrimary

    public var background: BackgroundColor

    public var padding: BackgroundPadding

    public var paddingSize: CGFloat = 0

    public init(background: BackgroundColor = .primary,
                padding: BackgroundPadding = .medium,
                @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.padding = padding
        self.background = background

        setBackground(background)
        setPadding(padding)
    }

    public var body: some View {
        self.content
            .padding(.all, paddingSize)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(Radius.medium)
    }

    private mutating func setPadding(_ padding: BackgroundPadding) {
        switch padding {
        case .medium:
            paddingSize = Constants.paddingM
        case .small:
            paddingSize = Constants.paddingS
        }
    }

    private mutating func setBackground(_ background: BackgroundColor) {
        switch background {
        case .primary:
            backgroundColor = Constants.colorPrimary
        case .secondary:
            backgroundColor = Constants.colorSecondary
        case .tertiary:
            backgroundColor = Constants.colorTertiary
        }
    }
}
