//
// Copyright © 2021 Alexander Romanov
// Palette.swift, created on 11.09.2021
//

import SwiftUI

public enum Palette: String, Sendable {
    case red
    case orange
    case yellow
    case green
    case blue
    case pink
    case gray
    case violet
    case black

    public var color: Color {
        switch self {
        case .red:
            Color.red
        case .orange:
            Color.orange
        case .yellow:
            Color.yellow
        case .green:
            Color.green
        case .blue:
            Color.blue
        case .pink:
            Color.pink
        case .gray:
            Color.gray
        case .violet:
            Color.purple
        case .black:
            Color.black
        }
    }

    public static let base: [Palette] = [.red, .orange, .yellow, .green, .blue, .pink, .gray, .black]
    public static let baseColors: [Color] = base.compactMap { color in
        color.color
    }
}
