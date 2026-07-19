//
// Copyright © 2024 Alexander Romanov
// BlankView.swift, created on 15.11.2024
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension EmptyStateView {
    func emptyStateSize(_ type: EmptyStateViewType) -> Self {
        var control = self
        control.type = type
        return control
    }
}
