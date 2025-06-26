//
// Copyright © 2024 Alexander Romanov
// View+Cursor.swift, created on 23.10.2024
//

import SwiftUI

#if os(macOS)
public extension View {
    func cursor(_ cursor: NSCursor) -> some View {
        onHover { inside in
            if inside {
                cursor.push()
            } else {
                NSCursor.pop()
            }
        }
    }
}
#endif
