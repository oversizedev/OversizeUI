//
// Copyright © 2024 Alexander Romanov
// Platform.swift, created on 07.09.2024
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public enum Platform {
    case iPhone, iPad, mac, tv, watch, vision, carPlay, other
}

private struct PlatformKey: EnvironmentKey {
    static let defaultValue: Platform = {
        #if canImport(UIKit)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return .iPhone
        case .pad:
            return .iPad
        case .tv:
            return .tv
        case .carPlay:
            return .carPlay
        case .mac:
            return .mac
        case .vision:
            return .vision
        case .unspecified:
            return .other
        @unknown default:
            return .other
        }
        #elseif os(watchOS)
        return .watch
        #elseif os(visionOS)
        return .vision
        #elseif os(macOS) || targetEnvironment(macCatalyst)
        return .mac
        #else
        return .other
        #endif
    }()
}

public extension EnvironmentValues {
    var platform: Platform {
        get { self[PlatformKey.self] }
        set { self[PlatformKey.self] = newValue }
    }
}
