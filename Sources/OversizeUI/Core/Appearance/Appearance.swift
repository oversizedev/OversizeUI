//
// Copyright © 2021 Alexander Romanov
// Appearance.swift, created on 11.19.2021
//

import SwiftUI

public enum Appearance: Int, Sendable {
    case system
    case light
    case dark

    public var colorScheme: ColorScheme? {
        switch self {
        case .system:
            nil
        case .light:
            .light
        case .dark:
            .dark
        }
    }

    public var name: String {
        switch self {
        case .system:
            "System"
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }

    public var image: Image {
        switch self {
        case .system:
            Image("System", bundle: .module)
        case .light:
            Image("Light", bundle: .module)
        case .dark:
            Image("Dark", bundle: .module)
        }
    }

    public static let allCases: [Appearance] = [.system, .light, .dark]
}
