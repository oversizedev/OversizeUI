//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public protocol ColorSelectorStyle {
    associatedtype Body: View
    typealias Configuration = ColorSelectorConfiguration

    func makeBody(configuration: Self.Configuration) -> Self.Body
}

public struct ColorSelectorConfiguration {
    public struct Label: View {
        public init<Content: View>(content: Content) {
            body = AnyView(content)
        }

        public var body: AnyView
    }

    let label: ColorSelectorConfiguration.Label
}

public struct HorizontalColorSelectorStyle: ColorSelectorStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                configuration.label
            }.padding(.horizontal)
                .animation(.default)
        }
        .padding(.vertical)
    }
}

public struct GridColorSelectorStyle: ColorSelectorStyle {
    public init() {}
    private let columns = [GridItem(.adaptive(minimum: 44))]

    public func makeBody(configuration: Configuration) -> some View {
        LazyVGrid(columns: columns, spacing: 10) {
            configuration.label
        }.padding()
    }
}

public struct DefaultColorSelectorStyle: ColorSelectorStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HorizontalColorSelectorStyle().makeBody(configuration: configuration)
    }
}

public struct AnyColorSelectorStyle: ColorSelectorStyle {
    private var _makeBody: (Configuration) -> AnyView

    public init<S: ColorSelectorStyle>(style: S) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}

struct ColorSelectorStyleStyleKey: EnvironmentKey {
    public static var defaultValue = AnyColorSelectorStyle(style: DefaultColorSelectorStyle())
}

public extension EnvironmentValues {
    var colorSelectorStyle: AnyColorSelectorStyle {
        get { self[ColorSelectorStyleStyleKey.self] }
        set { self[ColorSelectorStyleStyleKey.self] = newValue }
    }
}

public extension View {
    func colorSelectorStyle<S: ColorSelectorStyle>(_ style: S) -> some View {
        environment(\.colorSelectorStyle, AnyColorSelectorStyle(style: style))
    }
}
