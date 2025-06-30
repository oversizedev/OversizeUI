//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

public extension ListLayoutView {
    func toolbarImage(_ image: Image?) -> Self {
        var control = self
        control.logo = image
        return control
    }
}
