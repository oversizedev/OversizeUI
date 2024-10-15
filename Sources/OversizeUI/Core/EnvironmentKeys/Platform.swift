//
// Copyright © 2024 Alexander Romanov
// Platform.swift, created on 07.09.2024
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public enum Platform: Sendable {
    case iPhone, iPadOS, macOS, tvOS, watchOS, visionOS, carPlay, other
}

private struct PlatformKey: EnvironmentKey {
    static let defaultValue: Platform = {
        #if os(macOS) || targetEnvironment(macCatalyst)
        return .macOS
        #elseif os(watchOS)
        return .watchOS
        #elseif os(visionOS)
        return .vision
        #elseif canImport(UIKit)
        MainActor.assumeIsolated {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return .iPhone
            case .pad:
                return .iPadOS
            case .tv:
                return .tvOS
            case .carPlay:
                return .carPlay
            case .mac:
                return .macOS
            case .vision:
                return .visionOS
            case .unspecified:
                return .other
            @unknown default:
                return .other
            }
        }
        #else
        return .other
        #endif
    }()
}

// private struct PlatformKey: EnvironmentKey {
//
// #if os(macOS) || targetEnvironment(macCatalyst)
//    static let defaultValue: Platform = .macOS
// #elseif os(watchOS)
//    static let defaultValue: Platform = .watchOS
// #elseif os(visionOS)
//    static let defaultValue: Platform = .vision
// #elseif os(iOS)
//    static let defaultValue: Platform = .iPhone
// #else
//    static let defaultValue: Platform = .other
// #endif
//
// }

public extension EnvironmentValues {
    var platform: Platform {
        get { self[PlatformKey.self] }
        set { self[PlatformKey.self] = newValue }
    }
}
