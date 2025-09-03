//
// Copyright © 2025 Alexander Romanov
// File.swift, created on 13.08.2025
//

import SwiftUI

public extension View {
    func onChangeValue<V>(of value: V, _ action: @escaping (V) -> Void) -> some View where V: Equatable {
        #if os(visionOS)
        return onChange(of: value) { _, newValue in
            action(newValue)
        }
        #else
        if #available(iOS 17, macOS 14.0, *) {
            return self.onChange(of: value) { _, newValue in
                action(newValue)
            }
        } else {
            return onChange(of: value, perform: action)
        }
        #endif
    }
}
