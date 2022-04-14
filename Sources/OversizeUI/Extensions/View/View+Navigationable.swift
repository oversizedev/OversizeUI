//
// Copyright © 2022 Alexander Romanov
// View+Navigationable.swift
//

import SwiftUI

public extension View {
    func navigationable(_ navigationBarHidden: Bool = true) -> some View {
        NavigationView {
            self
                .navigationBarHidden(navigationBarHidden)
        }
    }
}
