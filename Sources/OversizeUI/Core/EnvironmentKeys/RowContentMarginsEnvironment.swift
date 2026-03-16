//
// Copyright © 2021 Alexander Romanov
// RowContentMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

private struct RowContentMarginsKey: EnvironmentKey {
    #if os(macOS)
    static let defaultValue: EdgeInsets = .init(top: .xSmall, leading: .small, bottom: .xSmall, trailing: .small)
    #else
    static let defaultValue: EdgeInsets = .init(top: .small, leading: .medium, bottom: .small, trailing: .medium)
    #endif
}

public extension EnvironmentValues {
    var rowContentMargins: EdgeInsets {
        get { self[RowContentMarginsKey.self] }
        set { self[RowContentMarginsKey.self] = newValue }
    }
}

public extension View {
    func rowContentMargins(_ margins: EdgeInsets) -> some View {
        environment(\.rowContentMargins, margins)
    }

    func rowContentMargins(_ margin: CGFloat) -> some View {
        environment(\.rowContentMargins, .init(top: margin, leading: margin, bottom: margin, trailing: margin))
    }
}
