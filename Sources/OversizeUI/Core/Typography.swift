//
// Copyright © 2022 Alexander Romanov
// Typography.swift
//

import SwiftUI

public enum FontDesignType: String, CaseIterable {
    case `default`, serif, round, mono

    public var system: Font.Design {
        switch self {
        case .default:
            return .default
        case .serif:
            return .serif
        case .round:
            return .rounded
        case .mono:
            return .monospaced
        }
    }
}

public struct Typography: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.isLoading) var isLoading

    public let fontStyle: Font.TextStyle
    public let isBold: Bool?

    private var fontDesign: Font.Design {
        switch fontStyle {
        case .largeTitle, .title, .title2, .title3, .headline, .subheadline:
            return theme.fontTitle.system
        case .body:
            return theme.fontParagraph.system
        case .caption, .caption2, .footnote, .callout:
            return theme.fontOverline.system
        @unknown default:
            return .default
        }
    }

    private var fontWeight: Font.Weight {
        switch fontStyle {
        case .largeTitle, .title:
            return isBold ?? true ? .heavy : .regular
        case .headline:
            return isBold ?? true ? .bold : .semibold
        default:
            return isBold ?? false ? .bold : .regular
        }
    }

    public init(fontStyle: Font.TextStyle, isBold: Bool? = nil) {
        self.fontStyle = fontStyle
        self.isBold = isBold
    }

    public func body(content: Content) -> some View {
        content
            .font(.system(fontStyle, design: fontDesign).weight(fontWeight))
    }
}

public extension View {
    func largeTitle(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .largeTitle, isBold: bold))
    }

    func title(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title, isBold: bold))
    }

    func title2(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title2, isBold: bold))
    }

    func title3(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title3, isBold: bold))
    }

    func headline(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .headline, isBold: bold))
    }

    func subheadline(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .subheadline, isBold: bold))
    }

    func body(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .body, isBold: bold))
    }

    func callout(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .callout, isBold: bold))
    }

    func footnote(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .footnote, isBold: bold))
    }

    func caption(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .caption, isBold: bold))
    }

    func caption2(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .caption2, isBold: bold))
    }
}

public extension View {
    func fontStyle(_ style: Font.TextStyle) -> some View {
        modifier(Typography(fontStyle: style))
    }

    @available(*, deprecated, message: "Use native color modificator")
    func fontStyle(_ style: Font.TextStyle, color: Color) -> some View {
        modifier(Typography(fontStyle: style))
            .foregroundColor(color)
    }
}
