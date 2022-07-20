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

    private var designTitle: Font.Design {
        theme.fontTitle.system
    }

    private var designParagraph: Font.Design {
        theme.fontParagraph.system
    }

    private var designOverline: Font.Design {
        theme.fontOverline.system
    }

    private var designButton: Font.Design {
        theme.fontButton.system
    }

    public var style: Font.TextStyle

    public var isBold: Bool = false

    // swiftlint:disable cyclomatic_complexity
    @ViewBuilder
    public func body(content: Content) -> some View {
        switch style {
        /// The font style for large titles.
        case .largeTitle:
            content
                .font(.system(.largeTitle, design: designTitle).weight(isBold ? .heavy : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for first level hierarchical headings.
        case .title:
            content
                .font(.system(.title, design: designTitle).weight(isBold ? .heavy : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for second level hierarchical headings.
        case .title2:
            content
                .font(.system(.title2, design: designTitle).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for third level hierarchical headings.
        case .title3:
            content
                .font(.system(.title3, design: designTitle).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for headings.
        case .headline:
            content
                .font(.system(.headline, design: designTitle).weight(isBold ? .bold : .semibold))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for subheadings.
        case .subheadline:
            content
                .font(.system(.subheadline, design: designTitle).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for body text.
        case .body:
            content
                .font(.system(.body, design: designParagraph).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for callouts.
        case .callout:
            content
                .font(.system(.callout, design: designOverline).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used in footnotes.
        case .footnote:
            content
                .font(.system(.footnote, design: designOverline).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for standard captions.
        case .caption:
            content
                .font(.system(.caption, design: designOverline).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        /// The font used for alternate captions.
        case .caption2:
            content
                .font(.system(.caption2, design: designOverline).weight(isBold ? .bold : .regular))
                .redacted(reason: isLoading ? .placeholder : .init())

        default:
            content
        }
    }
}

public extension View {
    func largeTitle(_ bold: Bool = true) -> some View {
        modifier(Typography(style: .largeTitle, isBold: bold))
    }

    func title(_ bold: Bool = true) -> some View {
        modifier(Typography(style: .title, isBold: bold))
    }

    func title2(_ bold: Bool = true) -> some View {
        modifier(Typography(style: .title2, isBold: bold))
    }

    func title3(_ bold: Bool = true) -> some View {
        modifier(Typography(style: .title3, isBold: bold))
    }

    func headline(_ bold: Bool = true) -> some View {
        modifier(Typography(style: .headline, isBold: bold))
    }

    func subheadline(_ bold: Bool = true) -> some View {
        modifier(Typography(style: .subheadline, isBold: bold))
    }

    func body(_ bold: Bool = false) -> some View {
        modifier(Typography(style: .body, isBold: bold))
    }

    func callout(_ bold: Bool = false) -> some View {
        modifier(Typography(style: .callout, isBold: bold))
    }

    func footnote(_ bold: Bool = false) -> some View {
        modifier(Typography(style: .footnote, isBold: bold))
    }

    func caption(_ bold: Bool = false) -> some View {
        modifier(Typography(style: .caption, isBold: bold))
    }

    func caption2(_ bold: Bool = false) -> some View {
        modifier(Typography(style: .caption2, isBold: bold))
    }
}

public extension View {
    func fontStyle(_ style: Font.TextStyle) -> some View {
        modifier(Typography(style: style))
    }

    @available(*, deprecated, message: "Use native color modificator")
    func fontStyle(_ style: Font.TextStyle, color: Color) -> some View {
        modifier(Typography(style: style))
            .foregroundColor(color)
    }
}
