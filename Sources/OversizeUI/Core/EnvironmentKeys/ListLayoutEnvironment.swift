//
// Copyright © 2026 Alexander Romanov
// ListStyle.swift, created on 19.03.2026
//

import SwiftUI

public enum ListLayoutStyle {
    case plain
    case insetGrouped
    case inset
}

extension EnvironmentValues {
    var listLayoutStyle: ListLayoutStyle {
        get {
            self[ListLayoutStyleKey.self]
        }
        set {
            self[ListLayoutStyleKey.self] = newValue
        }
    }
}

struct ListLayoutStyleKey: EnvironmentKey {
    static var defaultValue: ListLayoutStyle { .plain }
}
