//
// Copyright © 2021 Alexander Romanov
// RowContentMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

private struct RowContentMarginsKey: EnvironmentKey {
    #if os(macOS)
        static let defaultValue: EdgeSpaceInsets = .init(top: .xSmall, leading: .small, bottom: .xSmall, trailing: .small)
    #else
        static let defaultValue: EdgeSpaceInsets = .init(top: .small, leading: .medium, bottom: .small, trailing: .medium)
    #endif
}

public extension EnvironmentValues {
    var rowContentMargins: EdgeSpaceInsets {
        get { self[RowContentMarginsKey.self] }
        set { self[RowContentMarginsKey.self] = newValue }
    }
}

public extension View {
    func rowContentMargins(_ margins: EdgeSpaceInsets) -> some View {
        environment(\.rowContentMargins, margins)
    }

    func rowContentMargins(_ margin: Space) -> some View {
        environment(\.rowContentMargins, .init(top: margin, leading: margin, bottom: margin, trailing: margin))
    }
}

// MARK: Deprecated methods

public extension View {
    @available(*, deprecated, renamed: "rowContentMargins")
    func rowContentInset(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.rowContentMargins, insets)
    }

    @available(*, deprecated, renamed: "rowContentMargins")
    func rowContentInset(_ insets: Space) -> some View {
        environment(\.rowContentMargins, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }
}
