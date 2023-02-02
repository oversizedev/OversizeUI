//
// Copyright © 2022 Alexander Romanov
// Palette.swift
//

import SwiftUI

public enum Palette: String {
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
            return Color.red
        case .orange:
            return Color.orange
        case .yellow:
            return Color.yellow
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .pink:
            return Color.pink
        case .gray:
            return Color.gray
        case .violet:
            return Color.purple
        case .black:
            return Color.black
        }
    }

    public static var base: [Palette] = [.red, .orange, .yellow, .green, .blue, .pink, .gray, .black]
    public static var baseColors: [Color] = base.compactMap { color in
        color.color
    }
}
