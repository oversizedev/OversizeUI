//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

public extension Separator {
    func lineWidth(_ width: CGFloat) -> Self {
        var control = self
        control.lineWidth = width
        return control
    }
}
