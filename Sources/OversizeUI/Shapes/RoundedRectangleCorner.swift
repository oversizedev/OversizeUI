import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@available(iOS 15.0, macOS 14, tvOS 15.0, watchOS 9.0, *)
public struct RoundedRectangleCorner: Shape {
    private var radius: CGFloat = .infinity

    #if canImport(UIKit)
    private var corners: UIRectCorner = .allCorners
    #else
    private var corners: RectCorner = .allCorners
    #endif

    #if canImport(UIKit)
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public init(radius: Radius, corners: UIRectCorner) {
        self.radius = radius.rawValue
        self.corners = corners
    }
    #else
    public init(radius: CGFloat, corners: RectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public init(radius: Radius, corners: RectCorner) {
        self.radius = radius.rawValue
        self.corners = corners
    }
    #endif

    public func path(in rect: CGRect) -> Path {
        #if canImport(UIKit)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
        #else
        let path = NSBezierPath()

        let topLeftRadius = corners.contains(.topLeft) ? radius : 0
        let topRightRadius = corners.contains(.topRight) ? radius : 0
        let bottomLeftRadius = corners.contains(.bottomLeft) ? radius : 0
        let bottomRightRadius = corners.contains(.bottomRight) ? radius : 0

        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))

        path.line(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        if topRightRadius > 0 {
            path.curve(
                to: CGPoint(x: rect.maxX, y: rect.minY + topRightRadius),
                controlPoint1: CGPoint(x: rect.maxX - topRightRadius / 2, y: rect.minY),
                controlPoint2: CGPoint(x: rect.maxX, y: rect.minY + topRightRadius / 2)
            )
        }

        path.line(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        if bottomRightRadius > 0 {
            path.curve(
                to: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY),
                controlPoint1: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius / 2),
                controlPoint2: CGPoint(x: rect.maxX - bottomRightRadius / 2, y: rect.maxY)
            )
        }

        path.line(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        if bottomLeftRadius > 0 {
            path.curve(
                to: CGPoint(x: rect.minX, y: rect.maxY - bottomLeftRadius),
                controlPoint1: CGPoint(x: rect.minX + bottomLeftRadius / 2, y: rect.maxY),
                controlPoint2: CGPoint(x: rect.minX, y: rect.maxY - bottomLeftRadius / 2)
            )
        }

        path.line(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        if topLeftRadius > 0 {
            path.curve(
                to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY),
                controlPoint1: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius / 2),
                controlPoint2: CGPoint(x: rect.minX + topLeftRadius / 2, y: rect.minY)
            )
        }

        path.close()
        return Path(path.cgPath)
        #endif
    }
}

#if !canImport(UIKit)
public struct RectCorner: OptionSet, Sendable {
    public let rawValue: Int

    public static let topLeft = RectCorner(rawValue: 1 << 0)
    public static let topRight = RectCorner(rawValue: 1 << 1)
    public static let bottomLeft = RectCorner(rawValue: 1 << 2)
    public static let bottomRight = RectCorner(rawValue: 1 << 3)
    public static let allCorners: RectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
#endif
