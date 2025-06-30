//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension LayoutView {
    func toolbarImage(_ image: Image?) -> LayoutView {
        var control = self
        control.logo = image
        return control
    }
}
