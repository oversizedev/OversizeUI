//
// Copyright © 2026 Alexander Romanov
// ListStyle.swift, created on 19.03.2026
//

import SwiftUI

public enum ListLayoutStyle {
    case plain
    case inset
    case insetGrouped
    case smallInsetGrouped
    case grouped
}

extension EnvironmentValues {
    @Entry var listLayoutStyle: ListLayoutStyle = .plain
}
