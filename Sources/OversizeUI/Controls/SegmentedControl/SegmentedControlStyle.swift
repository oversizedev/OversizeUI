//
// Copyright © 2022 Alexander Romanov
// SegmentedControlStyle.swift
//

import SwiftUI

// MARK: - Styles

public enum SegmentedControlStyleType {
    case `default`
    case island(selected: SegmentedControlSeletionStyle = .shadowSurface)
    case islandLeading(selected: SegmentedControlSeletionStyle = .shadowSurface)
    case islandScroll(selected: SegmentedControlSeletionStyle = .shadowSurface)
    case onlySelection(selected: SegmentedControlSeletionStyle = .shadowSurface)
    case onlySelectionLeading(selected: SegmentedControlSeletionStyle = .shadowSurface)
    case onlySelectionScroll(selected: SegmentedControlSeletionStyle = .shadowSurface)
}

public enum SegmentedControlSeletionStyle {
    case shadowSurface
    case graySurface
    case accentSurface
}

public enum SegmentedControlUnseletionStyle {
    case clean
    case surface
}

// swiftlint:disable function_body_length
public extension View {
    func segmentedControlStyle(_ style: SegmentedControlStyleType) -> some View {
        switch style {
        case .default:
            let style: RectangleSegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: style.isEquallySpacing,
                                                        isShowBackground: style.isShowBackground,
                                                        seletionStyle: style.seletionStyle,
                                                        unseletionStyle: style.unseletionStyle,
                                                        style: style))
        case let .island(selected: selected):
            let style: IslandSegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: true,
                                                        isShowBackground: false,
                                                        seletionStyle: selected,
                                                        unseletionStyle: .surface,
                                                        style: style))
        case let .islandScroll(selected: selected):
            let style: ScrollSegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: false,
                                                        isShowBackground: false,
                                                        seletionStyle: selected,
                                                        unseletionStyle: .surface,
                                                        style: style))
        case let .onlySelection(selected: selected):
            let style: SelectionOnlySegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: true,
                                                        isShowBackground: false,
                                                        seletionStyle: selected,
                                                        unseletionStyle: .clean,
                                                        style: style))
        case let .onlySelectionLeading(selected: selected):
            let style: SelectionOnlySegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: false,
                                                        isShowBackground: false,
                                                        seletionStyle: selected,
                                                        unseletionStyle: .clean,
                                                        style: style))
        case let .onlySelectionScroll(selected: selected):
            let style: ScrollSegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: false,
                                                        isShowBackground: false,
                                                        seletionStyle: selected,
                                                        unseletionStyle: .clean,
                                                        style: style))
        case let .islandLeading(selected: selected):
            let style: IslandSegmentedControlStyle = .init()

            return environment(\.segmentedControlStyle,
                               AnySegmentedControlStyle(isEquallySpacing: false,
                                                        isShowBackground: false,
                                                        seletionStyle: selected,
                                                        unseletionStyle: .surface,
                                                        style: style))
        }
    }
}

// swiftlint:disable function_body_length superfluous_disable_command
public struct RectangleSegmentedControlStyle: SegmentedControlStyle {
    public init(isEquallySpacing: Bool = true,
                isShowBackground: Bool = true,
                seletionStyle: SegmentedControlSeletionStyle = .shadowSurface,
                unseletionStyle: SegmentedControlUnseletionStyle = .clean)
    {
        self.isEquallySpacing = isEquallySpacing
        self.isShowBackground = isShowBackground
        self.seletionStyle = seletionStyle
        self.unseletionStyle = unseletionStyle
    }

    public var isEquallySpacing: Bool = true
    public var isShowBackground: Bool = true
    public var seletionStyle: SegmentedControlSeletionStyle = .shadowSurface
    public var unseletionStyle: SegmentedControlUnseletionStyle = .clean

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.xxxSmall)
            .background(Color.surfaceSecondary)
    }
}

public struct SelectionOnlySegmentedControlStyle: SegmentedControlStyle {
    public var isEquallySpacing: Bool = true
    public var isShowBackground: Bool = false
    public var seletionStyle: SegmentedControlSeletionStyle = .shadowSurface
    public var unseletionStyle: SegmentedControlUnseletionStyle = .clean

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

public struct ScrollSegmentedControlStyle: SegmentedControlStyle {
    public var isEquallySpacing: Bool = false
    public var isShowBackground: Bool = false
    public var seletionStyle: SegmentedControlSeletionStyle = .graySurface
    public var unseletionStyle: SegmentedControlUnseletionStyle = .clean

    public init(isEquallySpacing: Bool = false,
                isShowBackground: Bool = false,
                seletionStyle: SegmentedControlSeletionStyle = .graySurface,
                unseletionStyle: SegmentedControlUnseletionStyle = .clean)
    {
        self.isEquallySpacing = isEquallySpacing
        self.isShowBackground = isShowBackground
        self.seletionStyle = seletionStyle
        self.unseletionStyle = unseletionStyle
    }

    public func makeBody(configuration: Configuration) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            configuration.label
        }
    }
}

public struct IslandSegmentedControlStyle: SegmentedControlStyle {
    public var isEquallySpacing: Bool = false
    public var isShowBackground: Bool = false
    public var seletionStyle: SegmentedControlSeletionStyle = .shadowSurface
    public var unseletionStyle: SegmentedControlUnseletionStyle = .surface

    public init(isEquallySpacing: Bool = false,
                isShowBackground: Bool = false,
                seletionStyle: SegmentedControlSeletionStyle = .shadowSurface,
                unseletionStyle: SegmentedControlUnseletionStyle = .surface)
    {
        self.isEquallySpacing = isEquallySpacing
        self.isShowBackground = isShowBackground
        self.seletionStyle = seletionStyle
        self.unseletionStyle = unseletionStyle
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

// MARK: - Support

public protocol SegmentedControlStyle {
    associatedtype Body: View
    typealias Configuration = SegmentedControlConfiguration

    var isEquallySpacing: Bool { get }
    var isShowBackground: Bool { get }
    var seletionStyle: SegmentedControlSeletionStyle { get }
    var unseletionStyle: SegmentedControlUnseletionStyle { get }

    func makeBody(configuration: Self.Configuration) -> Self.Body
}

public struct SegmentedControlConfiguration {
    public struct Label: View {
        public init(content: some View) {
            body = AnyView(content)
        }

        public var body: AnyView
    }

    public let label: SegmentedControlConfiguration.Label
}

public struct AnySegmentedControlStyle: SegmentedControlStyle {
    public var isEquallySpacing: Bool

    public var isShowBackground: Bool

    public var seletionStyle: SegmentedControlSeletionStyle

    public var unseletionStyle: SegmentedControlUnseletionStyle

    private var _makeBody: (Configuration) -> AnyView

    public init(isEquallySpacing: Bool,
                isShowBackground: Bool,
                seletionStyle: SegmentedControlSeletionStyle,
                unseletionStyle: SegmentedControlUnseletionStyle,
                style: some SegmentedControlStyle)
    {
        self.isEquallySpacing = isEquallySpacing
        self.isShowBackground = isShowBackground
        self.seletionStyle = seletionStyle
        self.unseletionStyle = unseletionStyle
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}

public struct SegmentedControlKey: EnvironmentKey {
    public static var defaultValue = AnySegmentedControlStyle(isEquallySpacing: true,
                                                              isShowBackground: true,
                                                              seletionStyle: .shadowSurface,
                                                              unseletionStyle: .clean,
                                                              style: RectangleSegmentedControlStyle())
}

public extension EnvironmentValues {
    var segmentedControlStyle: AnySegmentedControlStyle {
        get { self[SegmentedControlKey.self] }
        set { self[SegmentedControlKey.self] = newValue }
    }
}

public extension View {
    func segmentedControlStyle(_ style: some SegmentedControlStyle) -> some View {
        environment(\.segmentedControlStyle,
                    AnySegmentedControlStyle(isEquallySpacing: style.isEquallySpacing,
                                             isShowBackground: style.isShowBackground,
                                             seletionStyle: style.seletionStyle,
                                             unseletionStyle: style.unseletionStyle,
                                             style: style))
    }
}
