//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
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
