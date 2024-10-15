import SwiftUI

public enum FontDesignType: String, CaseIterable, Sendable {
    case `default`, serif, round, mono

    public var system: Font.Design {
        switch self {
        case .default:
            .default
        case .serif:
            .serif
        case .round:
            .rounded
        case .mono:
            .monospaced
        }
    }
}

public struct Typography: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings

    private let fontStyle: Font.TextStyle
    private let isBold: Bool?
    private let weight: Font.Weight?

    public nonisolated init(fontStyle: Font.TextStyle, isBold: Bool? = nil, weight: Font.Weight? = nil) {
        self.fontStyle = fontStyle
        self.isBold = isBold
        self.weight = weight
    }

    public func body(content: Content) -> some View {
        content
            .font(
                .system(fontStyle, design: fontDesign)
                    .weight(fontWeight)
                    .leading(.tight)
            )
            .lineSpacing(lineHeight * 0.2)
            .frame(minHeight: lineHeight)
    }

    private var lineHeight: CGFloat {
        switch fontStyle {
        case .largeTitle: return 44
        case .title: return 36
        case .title2: return 28
        case .title3, .headline: return 24
        case .subheadline, .body: return 20
        case .callout, .footnote, .caption, .caption2: return 16
        @unknown default: return 16
        }
    }

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
        }
        switch fontStyle {
        case .largeTitle, .title:
            return (isBold ?? true) ? .bold : .regular
        case .headline:
            return (isBold ?? true) ? .bold : .semibold
        default:
            return (isBold ?? false) ? .bold : .regular
        }
    }
}

public extension View {
    // Large Title
    nonisolated func largeTitle(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .largeTitle, isBold: bold))
    }

    nonisolated func largeTitle(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .largeTitle, weight: weight))
    }

    // Title
    nonisolated func title(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title, isBold: bold))
    }

    nonisolated func title(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .title, weight: weight))
    }

    // Title 2
    nonisolated func title2(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title2, isBold: bold))
    }

    nonisolated func title2(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .title2, weight: weight))
    }

    // Title 3
    nonisolated func title3(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title3, isBold: bold))
    }

    nonisolated func title3(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .title3, weight: weight))
    }

    // Headline
    nonisolated func headline(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .headline, isBold: bold))
    }

    nonisolated func headline(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .headline, weight: weight))
    }

    // Subheadline
    nonisolated func subheadline(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .subheadline, isBold: bold))
    }

    nonisolated func subheadline(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .subheadline, weight: weight))
    }

    // Body
    nonisolated func body(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .body, isBold: bold))
    }

    nonisolated func body(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .body, weight: weight))
    }

    // Callout
    nonisolated func callout(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .callout, isBold: bold))
    }

    nonisolated func callout(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .callout, weight: weight))
    }

    // Footnote
    nonisolated func footnote(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .footnote, isBold: bold))
    }

    nonisolated func footnote(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .footnote, weight: weight))
    }

    // Caption
    nonisolated func caption(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .caption, isBold: bold))
    }

    nonisolated func caption(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .caption, weight: weight))
    }

    // Caption 2
    nonisolated func caption2(_ bold: Bool = false) -> some View {
        modifier(Typography(fontStyle: .caption2, isBold: bold))
    }

    nonisolated func caption2(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .caption2, weight: weight))
    }
}
