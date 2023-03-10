//
// Copyright © 2021 Alexander Romanov
// Appearance.swift, created on 11.19.2021
//

import SwiftUI

public enum Appearance: Int {
    case system
    case light
    case dark

    public var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }

    public var name: String {
        switch self {
        case .system:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }

    public var image: Image {
        switch self {
        case .system:
            return Image("System", bundle: .module)
        case .light:
            return Image("Light", bundle: .module)
        case .dark:
            return Image("Dark", bundle: .module)
        }
    }

    public static var allCases: [Appearance] = [.system, .light, .dark]
}
