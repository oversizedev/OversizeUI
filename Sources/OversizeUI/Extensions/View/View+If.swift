//
// Copyright © 2023 Alexander Romanov
// View+If.swift
//

import SwiftUI

public extension View {
    @ViewBuilder
    func `if`(_ condition: Bool, _ modifications: (Self) -> some View) -> some View {
        if condition {
            modifications(self)
        } else {
            self
        }
    }
}
