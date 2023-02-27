//
// Copyright © 2021 Alexander Romanov
// View+Alignment.swift
//

import SwiftUI

public extension View {
    func vCenter() -> some View {
        frame(maxHeight: .infinity, alignment: .center)
    }

    func vTop() -> some View {
        frame(maxHeight: .infinity, alignment: .top)
    }

    func vBottom() -> some View {
        frame(maxHeight: .infinity, alignment: .bottom)
    }

    func hCenter() -> some View {
        frame(maxWidth: .infinity, alignment: .center)
    }

    func hLeading() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }

    func hTrailing() -> some View {
        frame(maxWidth: .infinity, alignment: .trailing)
    }
}
