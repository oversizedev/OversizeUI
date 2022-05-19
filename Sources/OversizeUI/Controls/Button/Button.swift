//
// Copyright © 2022 Alexander Romanov
// Button.swift
//

import SwiftUI

public enum ButtonBorderShape {
    case automatic
    case capsule
    case roundedRectangle(radius: Radius = .medium)
}

public enum ButtonRole {
    case destructive
    case cancel
}

public enum ButtonType: Int, CaseIterable {
    case accent
    case primary
    case secondary
    case tertiary
}

@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct OversizeButtonStyle: ButtonStyle {
    private let type: ButtonType
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isLoading) private var isLoading: Bool
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.controlSize) var controlSize: ControlSize
    // private let role: ButtonRole?
    private var isRounded: Bool = false
    private var buttonBorderShape: ButtonBorderShape = .automatic

    public init(_ type: ButtonType) {
        self.type = type
    }

//    public init(type: ButtonType, role: ButtonRole? = nil) {
//        self.type = type
//        self.role = role
//    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: controlSize == .large ? .infinity : nil)
    }

//    func foregroundColor(for role: ButtonRole?) -> Color? {
//      switch (type, role) {
//      case (.accent, .destructive?):
//          return .red
//        case (.increased, .destructive?):
//          return .white
//        case (.increased, _):
//          return .black
//        case (_, _):
//          return nil
//      }
//    }

    public func buttonBorderShape(_ buttonBorderShape: ButtonBorderShape) -> OversizeButtonStyle {
        var control = self
        control.buttonBorderShape = buttonBorderShape
        return control
    }

    public func buttonRounded(_ rounded: Bool) -> OversizeButtonStyle {
        var control = self
        control.isRounded = rounded
        return control
    }
}

// public extension ButtonStyle where Self == OversizeButtonStyle {
//    static var primary: OversizeButtonStyle {
//        OversizeButtonStyle()
//    }
//    static var secondary: ButtonStyleExtended {
//        ButtonStyleExtended(style: .secondary)
//    }
//    static var text: ButtonStyleExtended {
//        ButtonStyleExtended(style: .text)
//    }
//    static var accent: ButtonStyleExtended {
//        ButtonStyleExtended(style: .accent)
//    }
//    static var gray: ButtonStyleExtended {
//        ButtonStyleExtended(style: .gray)
//    }
//    static var link: ButtonStyleExtended {
//        ButtonStyleExtended(style: .link)
//    }
// }
