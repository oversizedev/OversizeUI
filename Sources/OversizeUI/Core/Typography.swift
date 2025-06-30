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

    #if os(macOS)
    private var lineHeight: CGFloat {
        switch fontStyle {
        case .largeTitle: 32
        case .title: 28
        case .title2: 24
        case .title3: 20
        case .headline: 16
        case .subheadline: 20
        case .body, .callout, .footnote, .caption, .caption2: 16
        default: 16
        }
    }
    #else
    private var lineHeight: CGFloat {
        switch fontStyle {
        case .largeTitle: 44
        case .title: 36
        case .title2: 28
        case .title3, .headline, .body: 24
        case .subheadline: 20
        case .callout, .footnote, .caption, .caption2: 16
        default: 16
        }
    }
    #endif

    private var fontDesign: Font.Design {
        switch fontStyle {
        case .largeTitle, .title, .title2, .title3, .headline, .subheadline:
            theme.fontTitle.system
        case .body:
            theme.fontParagraph.system
        case .caption, .caption2, .footnote, .callout:
            theme.fontOverline.system
        default:
            .default
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

/// Typography modifiers that provide semantic text styling with design system integration.
///
/// These modifiers apply consistent typography styles that automatically adapt to:
/// - Dynamic Type settings for accessibility
/// - Light and dark appearance modes  
/// - Platform conventions (iOS, macOS, tvOS, watchOS)
/// - Custom theme typography settings
///
/// The typography system provides a semantic hierarchy from large titles to small captions,
/// ensuring consistent visual relationships and accessibility compliance.
///
/// ```swift
/// VStack(alignment: .leading) {
///     Text("Main Title")
///         .largeTitle(.bold)
///     
///     Text("Section Header")
///         .title2()
///     
///     Text("Body content with proper hierarchy")
///         .body()
///     
///     Text("Supporting information")
///         .caption(.medium)
/// }
/// ```
///
/// ## Topics
///
/// ### Display Typography
/// - ``largeTitle(_:)-5xnbj``
/// - ``largeTitle(_:)-8bhhy``
///
/// ### Title Hierarchy
/// - ``title(_:)-5l7py``
/// - ``title(_:)-5tq7d``
/// - ``title2(_:)-1h8p5``
/// - ``title2(_:)-7q4q5``
/// - ``title3(_:)-8k90n``
/// - ``title3(_:)-2vzdf``
///
/// ### Content Typography
/// - ``headline(_:)-43xce``
/// - ``headline(_:)-92efm``
/// - ``subheadline(_:)-4g97e``
/// - ``subheadline(_:)-89q5p``
/// - ``body(_:)-1z89x``
/// - ``body(_:)-15dbt``
/// - ``callout(_:)-8xr3n``
/// - ``callout(_:)-2f5a8``
///
/// ### Supporting Typography
/// - ``footnote(_:)-8kqrw``
/// - ``footnote(_:)-8ycaw``
/// - ``caption(_:)-9oysj``
/// - ``caption(_:)-6y8n9``
/// - ``caption2(_:)-7pn4x``
/// - ``caption2(_:)-16kby``
///
/// ## See Also
/// - <doc:DesignSystem/Typography>
/// - ``Typography``
public extension View {
    
    // MARK: - Large Title
    
    /// Applies large title typography style with optional bold formatting.
    ///
    /// Large titles are used for the most prominent text on screen, typically
    /// app names, main screen titles, or hero content.
    ///
    /// - Parameter bold: Whether to apply bold formatting (default: true)
    /// - Returns: A view with large title typography applied
    ///
    /// ```swift
    /// Text("Welcome to MyApp")
    ///     .largeTitle()
    /// ```
    nonisolated func largeTitle(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .largeTitle, isBold: bold))
    }

    /// Applies large title typography style with custom font weight.
    ///
    /// - Parameter weight: The specific font weight to apply
    /// - Returns: A view with large title typography and custom weight applied
    ///
    /// ```swift
    /// Text("App Title")
    ///     .largeTitle(.heavy)
    /// ```
    nonisolated func largeTitle(_ weight: Font.Weight) -> some View {
        modifier(Typography(fontStyle: .largeTitle, weight: weight))
    }

    // MARK: - Title
    
    /// Applies title typography style with optional bold formatting.
    ///
    /// Titles are used for primary section headers and important content headings.
    ///
    /// - Parameter bold: Whether to apply bold formatting (default: true)
    /// - Returns: A view with title typography applied
    ///
    /// ```swift
    /// Text("Settings")
    ///     .title()
    /// ```
    nonisolated func title(_ bold: Bool = true) -> some View {
        modifier(Typography(fontStyle: .title, isBold: bold))
    }

    /// Applies title typography style with custom font weight.
    ///
    /// - Parameter weight: The specific font weight to apply
    /// - Returns: A view with title typography and custom weight applied
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
