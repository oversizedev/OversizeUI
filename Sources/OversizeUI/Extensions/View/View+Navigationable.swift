//
// Copyright © 2021 Alexander Romanov
// View+Navigationable.swift, created on 14.04.2022
//

import SwiftUI

public extension View {
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    func navigationable(_ navigationBarHidden: Bool = true) -> some View {
        NavigationView {
            self
            #if os(iOS)
            .navigationBarHidden(navigationBarHidden)
            #endif
        }
    }
}
