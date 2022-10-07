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

    private let fontStyle: Font.TextStyle
    private let isBold: Bool?
    private let weight: Font.Weight?

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
        if let weight {
            return weight
        } else {
            switch fontStyle {
            case .largeTitle, .title:
                return isBold ?? true ? .heavy : .regular
            case .headline:
                return isBold ?? true ? .bold : .semibold
            default:
                return isBold ?? false ? .bold : .regular
            }
        }
    }

    public init(fontStyle: Font.TextStyle, isBold: Bool? = nil, weight: Font.Weight? = nil) {
        self.fontStyle = fontStyle
        self.isBold = isBold
        self.weight = weight
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

    func largeTitle(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .largeTitle, weight: weight))
    }

    func title(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .title, weight: weight))
    }

    func title2(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .title2, weight: weight))
    }

    func title3(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .title3, weight: weight))
    }

    func headline(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .headline, weight: weight))
    }

    func subheadline(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .subheadline, weight: weight))
    }

    func body(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .body, weight: weight))
    }

    func callout(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .callout, weight: weight))
    }

    func footnote(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .footnote, weight: weight))
    }

    func caption(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .caption, weight: weight))
    }

    func caption2(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .caption2, weight: weight))
    }
}

public extension View {
    func fontStyle(_ style: Font.TextStyle) -> some View {
        modifier(Typography(fontStyle: style))
    }

    // @available(*, deprecated, message: "Use native color modificator")
    func fontStyle(_ style: Font.TextStyle, color: Color) -> some View {
        modifier(Typography(fontStyle: style))
            .foregroundColor(color)
    }
}
