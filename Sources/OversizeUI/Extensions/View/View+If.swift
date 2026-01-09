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

    @ViewBuilder
    nonisolated func `if`(_ condition: Bool, then transformThen: (Self) -> some View, else transformElse: (Self) -> some View) -> some View {
        if condition {
            transformThen(self)
        } else {
            transformElse(self)
        }
    }

    @ViewBuilder
    func `if`(@ViewBuilder _ modifications: (Self) -> (some View)?) -> some View {
        if let view = modifications(self) {
            view
        } else {
            self
        }
    }
}

public extension View {

    @ViewBuilder
    func ifUnavailable26(@ViewBuilder _ modifications: (Self) -> some View) -> some View {
        if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
            self
        } else {
            modifications(self)
        }
    }
}
