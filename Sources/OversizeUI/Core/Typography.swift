//
// Copyright © 2021 Alexander Romanov
// Created on 12.09.2021
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
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    @Environment(\.sizeCategory) var sizeCategory

    private var sizeMultiplicator: CGFloat {
        switch sizeCategory {
        case .extraSmall:
            return 0.7
        case .small:
            return 0.8
        case .medium:
            return 0.9
        case .large:
            return 1
        case .extraLarge:
            return 1.2
        case .extraExtraLarge:
            return 1.4
        case .extraExtraExtraLarge:
            return 1.5
        case .accessibilityMedium:
            return 1.8
        case .accessibilityLarge:
            return 2.0
        case .accessibilityExtraLarge:
            return 2.2
        case .accessibilityExtraExtraLarge:
            return 2.4
        case .accessibilityExtraExtraExtraLarge:
            return 2.6
        @unknown default:
            return 1
        }
    }

    private var designTitle: Font.Design {
        appearanceSettings.fontTitle.system
    }

    private var designParagraph: Font.Design {
        appearanceSettings.fontParagraph.system
    }

    private var designOverline: Font.Design {
        appearanceSettings.fontOverline.system
    }

    private var designButton: Font.Design {
        appearanceSettings.fontButton.system
    }

    public enum Style {
        case largeTitle
        case title1
        case title2
        case title3
        case subtitle1
        case subtitle2
        case paragraph1
        case paragraph2
        case button
        case caption
        case overline
    }

    public var style: Style

    // swiftlint:disable cyclomatic_complexity
    @ViewBuilder
    public func body(content: Content) -> some View {
        switch style {
        case .largeTitle:
            content.font(.system(size: 34 * sizeMultiplicator, weight: .heavy, design: designTitle))
        case .title1:
            content.font(.system(size: 28 * sizeMultiplicator, weight: .heavy, design: designTitle))
        case .title2:
            content.font(.system(size: 22 * sizeMultiplicator, weight: .bold, design: designTitle))
        case .title3:
            content.font(.system(size: 20 * sizeMultiplicator, weight: .bold, design: designTitle))
        case .subtitle1:
            content.font(.system(size: 16 * sizeMultiplicator, weight: .semibold, design: designTitle))
        case .subtitle2:
            content.font(.system(size: 14 * sizeMultiplicator, weight: .regular, design: designTitle))
        case .paragraph1:
            content.font(.system(size: 16 * sizeMultiplicator, weight: .regular, design: designParagraph))
        case .paragraph2:
            content.font(.system(size: 14 * sizeMultiplicator, weight: .regular, design: designParagraph))
        case .button:
            content.font(.system(size: 16 * sizeMultiplicator, weight: .bold, design: designButton))
        case .caption:
            content.font(.system(size: 12 * sizeMultiplicator, weight: .medium, design: designOverline))
        case .overline:
            content
                .font(.system(size: 12 * sizeMultiplicator, weight: .bold, design: designOverline))
                .textCase(.uppercase)
        }
    }
}

public extension View {
    func fontStyle(_ style: Typography.Style) -> some View {
        modifier(Typography(style: style))
    }

    func fontStyle(_ style: Typography.Style, color: Color) -> some View {
        modifier(Typography(style: style))
            .foregroundColor(color)
    }
}

// extension Font {
//
//    static let largeTitle =
//    static let title1
//    static let title2
//    static let title3
//    static let subtitle1
//    static let subtitle2
//    static let paragraph1
//    static let paragraph2
//    static let button
//    static let caption
//    static let overline
//
//    static let appTitle = appFont(size: 32).weight(.semibold)
//    static let appBody = appFont(size: 20).weight(.medium)
//    static let appCaption = appFont(size: 14).weight(.regular)
//
//    static func appFont(size: CGFloat) -> Font {
//            return Font.custom("Zilla Slab", size: size)
//        }
// }
