//
// Copyright © 2021 Alexander Romanov
// View+If.swift, created on 07.02.2023
//

import SwiftUI

public extension View {
    @ViewBuilder
    nonisolated func `if`(_ condition: Bool, _ modifications: (Self) -> some View) -> some View {
        if condition {
            modifications(self)
        } else {
            self
        }
    }
}
