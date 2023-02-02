//
// Copyright © 2022 Alexander Romanov
// LibraryContent.swift
//

import SwiftUI

public struct LibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    public var views: [LibraryItem] {
        LibraryItem(
            Surface { Text("Surface") },
            category: .control
        )
        LibraryItem(
            Icon(.airplay),
            category: .control
        )
    }

    @LibraryContentBuilder
    public func modifiers(base: Text) -> [LibraryItem] {
        LibraryItem(
            base
                .body()
                .foregroundOnBackgroundHighEmphasis()
        )
    }
}
