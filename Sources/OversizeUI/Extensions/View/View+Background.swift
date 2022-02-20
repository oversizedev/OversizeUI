//
// Copyright © 2022 Alexander Romanov
// View+Background.swift
//

import SwiftUI

// swiftlint:disable opening_brace
public extension View {
    func embedInBackground(background: BackgroundColor = .primary,
                           padding: BackgroundPadding = .medium) -> some View
    {
        Background(background: background,
                   padding: padding) { self }
    }
}
