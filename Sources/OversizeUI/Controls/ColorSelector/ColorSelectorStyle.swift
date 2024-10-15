//
// Copyright © 2021 Alexander Romanov
// ColorSelectorStyle.swift, created on 11.09.2021
//

import SwiftUI

public protocol ColorSelectorStyle: Sendable {
    associatedtype Body: View
    typealias Configuration = ColorSelectorConfiguration

    func makeBody(configuration: Self.Configuration) -> Self.Body
}

public struct ColorSelectorConfiguration: Sendable {
    public struct Label: View {
        public init(content: some View) {
            body = AnyView(content)
        }

        public var body: AnyView
    }

    let label: ColorSelectorConfiguration.Label
}

public struct DefaultColorSelectorStyle: ColorSelectorStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HorizontalColorSelectorStyle().makeBody(configuration: configuration)
    }
}

struct ColorSelectorStyleStyleKey: EnvironmentKey {
    public static let defaultValue = AnyColorSelectorStyle(style: DefaultColorSelectorStyle())
}

public extension EnvironmentValues {
    var colorSelectorStyle: AnyColorSelectorStyle {
        get { self[ColorSelectorStyleStyleKey.self] }
        set { self[ColorSelectorStyleStyleKey.self] = newValue }
    }
}

public extension View {
    func colorSelectorStyle(_ style: some ColorSelectorStyle) -> some View {
        environment(\.colorSelectorStyle, AnyColorSelectorStyle(style: style))
    }
}
