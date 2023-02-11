//
// Copyright © 2021 Alexander Romanov
// View+Platform.swift, created on 19.10.2021
//

import SwiftUI

public extension View {
    func iOS(_ modifier: (Self) -> some View) -> some View {
        #if os(iOS)
            return modifier(self)
        #else
            return self
        #endif
    }
}

public extension View {
    func macOS(_ modifier: (Self) -> some View) -> some View {
        #if os(macOS)
            return modifier(self)
        #else
            return self
        #endif
    }
}

public extension View {
    func tvOS(_ modifier: (Self) -> some View) -> some View {
        #if os(tvOS)
            return modifier(self)
        #else
            return self
        #endif
    }
}

public extension View {
    func watchOS(_ modifier: (Self) -> some View) -> some View {
        #if os(watchOS)
            return modifier(self)
        #else
            return self
        #endif
    }
}
