//
// Copyright © 2021 Alexander Romanov
// View+Available.swift, created on 23.12.2022
//

import SwiftUI

public extension View {
    @_disfavoredOverload
    @ViewBuilder
    func scrollContentBackground(_ visibility: Visibility) -> some View {
        if #available(iOS 16, *) {
            self.scrollContentBackground(visibility)
        } else {
            self
        }
    }

    @_disfavoredOverload
    @ViewBuilder
    func presentationDragIndicator(_ visibility: Visibility) -> some View {
        if #available(iOS 16, *) {
            self.presentationDragIndicator(visibility)
        } else {
            self
        }
    }
}
