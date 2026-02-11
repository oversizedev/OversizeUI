//
// Copyright © 2021 Alexander Romanov
// ScreenEnvironment.swift, created on 26.02.2022
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif
#if os(watchOS)
import WatchKit
#endif

// MARK: - ScreenSize

public struct ScreenSize: Sendable {
    public let width: CGFloat
    public let height: CGFloat

    private let _safeAreaTop: CGFloat
    private let _safeAreaBottom: CGFloat
    private let _safeAreaLeading: CGFloat
    private let _safeAreaTrailing: CGFloat

    @available(*, deprecated, message: "Use @Environment(\\.safeAreaInsets) instead")
    public var safeAreaTop: CGFloat {
        _safeAreaTop
    }

    @available(*, deprecated, message: "Use @Environment(\\.safeAreaInsets) instead")
    public var safeAreaBottom: CGFloat {
        _safeAreaBottom
    }

    @available(*, deprecated, message: "Use @Environment(\\.safeAreaInsets) instead")
    public var safeAreaLeading: CGFloat {
        _safeAreaLeading
    }

    @available(*, deprecated, message: "Use @Environment(\\.safeAreaInsets) instead")
    public var safeAreaTrailing: CGFloat {
        _safeAreaTrailing
    }

    public init(
        width: CGFloat,
        height: CGFloat,
        safeAreaTop: CGFloat = 0,
        safeAreaBottom: CGFloat = 0,
        safeAreaLeading: CGFloat = 0,
        safeAreaTrailing: CGFloat = 0
    ) {
        self.width = width
        self.height = height
        _safeAreaTop = safeAreaTop
        _safeAreaBottom = safeAreaBottom
        _safeAreaLeading = safeAreaLeading
        _safeAreaTrailing = safeAreaTrailing
    }

    public init(geometry: GeometryProxy) {
        self.init(
            width: geometry.size.width,
            height: geometry.size.height,
            safeAreaTop: geometry.safeAreaInsets.top,
            safeAreaBottom: geometry.safeAreaInsets.bottom,
            safeAreaLeading: geometry.safeAreaInsets.leading,
            safeAreaTrailing: geometry.safeAreaInsets.trailing
        )
    }
}

// MARK: - EnvironmentValues

public extension EnvironmentValues {
    @Entry var screenSize: ScreenSize = {
        #if os(iOS) || os(tvOS)
        return MainActor.assumeIsolated {
            guard let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive })
                ?? UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first
            else {
                return ScreenSize(width: 375, height: 667)
            }

            let screenBounds = windowScene.screen.bounds
            let safeArea = windowScene.windows.first?.safeAreaInsets ?? .zero

            return ScreenSize(
                width: screenBounds.width,
                height: screenBounds.height,
                safeAreaTop: safeArea.top,
                safeAreaBottom: safeArea.bottom,
                safeAreaLeading: safeArea.left,
                safeAreaTrailing: safeArea.right
            )
        }
        #elseif os(macOS)
        return MainActor.assumeIsolated {
            guard let screen = NSScreen.main else {
                return ScreenSize(width: 1440, height: 900)
            }
            let safeArea = NSApp?.keyWindow?.contentView?.safeAreaInsets ?? NSEdgeInsets()
            return ScreenSize(
                width: screen.frame.width,
                height: screen.frame.height,
                safeAreaTop: safeArea.top,
                safeAreaBottom: safeArea.bottom,
                safeAreaLeading: safeArea.left,
                safeAreaTrailing: safeArea.right
            )
        }
        #elseif os(watchOS)
        return MainActor.assumeIsolated {
            let bounds = WKInterfaceDevice.current().screenBounds
            return ScreenSize(width: bounds.width, height: bounds.height)
        }
        #elseif os(visionOS)
        return ScreenSize(width: 1280, height: 720)
        #else
        return ScreenSize(width: 375, height: 667)
        #endif
    }()

    @Entry var safeAreaInsets: EdgeInsets = {
        #if os(iOS) || os(tvOS)
        return MainActor.assumeIsolated {
            let window = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .filter { $0.activationState == .foregroundActive }
                .flatMap { $0.windows }
                .first(where: { $0.isKeyWindow })
                ?? UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first

            let safeArea = window?.safeAreaInsets ?? .zero
            return EdgeInsets(
                top: safeArea.top,
                leading: safeArea.left,
                bottom: safeArea.bottom,
                trailing: safeArea.right
            )
        }
        #elseif os(macOS)
        return MainActor.assumeIsolated {
            let safeArea = NSApp?.keyWindow?.contentView?.safeAreaInsets ?? NSEdgeInsets()
            return EdgeInsets(
                top: safeArea.top,
                leading: safeArea.left,
                bottom: safeArea.bottom,
                trailing: safeArea.right
            )
        }
        #else
        return EdgeInsets()
        #endif
    }()
}

// MARK: - View Extensions

public extension View {
    func screenSize(_ size: ScreenSize) -> some View {
        environment(\.screenSize, size)
    }

    func screenSize(_ geometry: GeometryProxy) -> some View {
        environment(\.screenSize, ScreenSize(geometry: geometry))
    }
}
