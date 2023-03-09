//
// Copyright © 2021 Alexander Romanov
// View+Available.swift, created on 23.12.2022
//

import SwiftUI

public extension View {
    @available(tvOS, unavailable)
    @_disfavoredOverload
    @ViewBuilder
    func scrollContentBackground(_ visibility: Visibility) -> some View {
        if #available(iOS 16, macOS 13.0, watchOS 9.0, *) {
            self.scrollContentBackground(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationDragIndicator(_ visibility: Visibility) -> some View {
        if #available(iOS 16, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            self.presentationDragIndicator(visibility)
        } else {
            self
        }
    }
}
