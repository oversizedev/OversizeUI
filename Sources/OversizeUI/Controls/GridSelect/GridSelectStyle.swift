//
// Copyright © 2022 Alexander Romanov
// GridSelectStyle.swift
//

import SwiftUI

// MARK: - Styles

public enum GridSelectStyleType {
    case `default`(selected: GridSelectSeletionStyle = .accentSurface, icon: GridSelectSeletionIconStyle = .none)
    case onlySelection(selected: GridSelectSeletionStyle = .shadowSurface, icon: GridSelectSeletionIconStyle = .none)
}

public extension View {
    func gridSelectStyle(_ style: GridSelectStyleType) -> some View {
        switch style {
        case let .default(selected: selected, icon: icon):
            let style: IslandGridSelectStyle = .init()

            return environment(\.gridSelectStyle, AnyGridSelectStyle(seletionStyle: selected,
                                                                     unseletionStyle: style.unseletionStyle,
                                                                     icon: icon,
                                                                     style: style))
        case let .onlySelection(selected: selected, icon: icon):
            let style: SelectionOnlyGridSelectStyle = .init()

            return environment(\.gridSelectStyle, AnyGridSelectStyle(seletionStyle: selected,
                                                                     unseletionStyle: style.unseletionStyle,
                                                                     icon: icon,
                                                                     style: style))
        }
    }
}

public struct IslandGridSelectStyle: GridSelectStyle {
    public init() {}
    public var seletionStyle: GridSelectSeletionStyle = .accentSurface
    public var unseletionStyle: GridSelectUnseletionStyle = .surface
    public var icon: GridSelectSeletionIconStyle = .none

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

public struct SelectionOnlyGridSelectStyle: GridSelectStyle {
    public init() {}
    public var seletionStyle: GridSelectSeletionStyle = .shadowSurface
    public var unseletionStyle: GridSelectUnseletionStyle = .clean
    public var icon: GridSelectSeletionIconStyle = .none

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

// MARK: - Support

public enum GridSelectSeletionIconStyle {
    case none
    case checkbox(alignment: Alignment = .bottomTrailing)
    case radio(alignment: Alignment = .bottomTrailing)
}

public enum GridSelectSeletionStyle {
    case shadowSurface
    case graySurface
    case accentSurface
}

public enum GridSelectUnseletionStyle {
    case clean
    case surface
}

public protocol GridSelectStyle {
    associatedtype Body: View
    typealias Configuration = GridSelectConfiguration

    var seletionStyle: GridSelectSeletionStyle { get }
    var unseletionStyle: GridSelectUnseletionStyle { get }
    var icon: GridSelectSeletionIconStyle { get }

    func makeBody(configuration: Self.Configuration) -> Self.Body
}

public struct GridSelectConfiguration {
    /// A type-erased content of a `Card`.
    public struct Label: View {
        init<Content: View>(content: Content) {
            body = AnyView(content)
        }

        public var body: AnyView
    }

    let label: GridSelectConfiguration.Label
}

public struct AnyGridSelectStyle: GridSelectStyle {
    public var seletionStyle: GridSelectSeletionStyle
    public var unseletionStyle: GridSelectUnseletionStyle
    public var icon: GridSelectSeletionIconStyle

    private var _makeBody: (Configuration) -> AnyView

    public init<S: GridSelectStyle>(
        seletionStyle: GridSelectSeletionStyle,
        unseletionStyle: GridSelectUnseletionStyle,
        icon: GridSelectSeletionIconStyle,
        style: S
    ) {
        self.seletionStyle = seletionStyle
        self.unseletionStyle = unseletionStyle
        self.icon = icon
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}

struct GridSelectStyleKey: EnvironmentKey {
    public static var defaultValue = AnyGridSelectStyle(seletionStyle: .accentSurface,
                                                        unseletionStyle: .surface,
                                                        icon: .none,
                                                        style: IslandGridSelectStyle())
}

public extension EnvironmentValues {
    var gridSelectStyle: AnyGridSelectStyle {
        get { self[GridSelectStyleKey.self] }
        set { self[GridSelectStyleKey.self] = newValue }
    }
}

public extension View {
    func gridSelectStyle<S: GridSelectStyle>(_ style: S) -> some View {
        environment(\.gridSelectStyle, AnyGridSelectStyle(seletionStyle: style.seletionStyle,
                                                          unseletionStyle: style.unseletionStyle,
                                                          icon: style.icon,
                                                          style: style))
    }
}
