//
// Copyright © 2022 Alexander Romanov
// Color+Hex.swift
//

import SwiftUI
#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

public typealias ColorComponentsRGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

// swiftlint:disable all
public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }

    init(hex: String?) {
        if let hex {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue: Double(b) / 255,
                opacity: Double(a) / 255
            )
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}

public extension Color {
    func hexString() -> String {
        hexStringFromColorComponents(rgba)
    }

    var rgba: ColorComponentsRGBA {
        #if canImport(AppKit)
            let color = NSColor(self).usingColorSpace(.displayP3)!
        #elseif canImport(UIKit)
            let color: UIColor = .init(self)
        #endif

        var t = (CGFloat(), CGFloat(), CGFloat(), CGFloat())
        color.getRed(&t.0, green: &t.1, blue: &t.2, alpha: &t.3)
        return t
    }
}

public func hexStringFromColorComponents(_ components: ColorComponentsRGBA) -> String {
    // print("hexStringFromColorComponents → \(components)")

    if components.alpha == 1.0 {
        // Color is in hex format without alpha
        let rgb: Int = hexIntFromColorComponents(rgb: components)
        // print("hexString rgb → \(rgb)")

        return String(format: "#%06x", rgb)
    } else {
        // Color is in hex format with alpha
        let rgba: Int = hexIntFromColorComponents(rgba: components)
        // print("hexString rgba → \(rgba)")

        return String(format: "#%08x", rgba)
    }
}

private func hexIntFromColorComponents(rgb components: ColorComponentsRGBA) -> Int {
    let (r, g, b, _) = components
    return (Int)(r * 255) << 16 | Int(g * 255) << 8 | Int(b * 255) << 0
}

private func hexIntFromColorComponents(rgba components: ColorComponentsRGBA) -> Int {
    let (r, g, b, a) = components
    return (Int)(r * 255) << 24 | Int(g * 255) << 16 | Int(b * 255) << 8 | Int(a * 255) << 0
}

struct Hex_Preview: PreviewProvider {
    static var previews: some View {
        let green: Color = .init(hex: "#00FF00")

        return Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(green)
    }
}
