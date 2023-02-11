//
// Copyright © 2021 Alexander Romanov
// View+Background.swift, created on 25.04.2021
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
