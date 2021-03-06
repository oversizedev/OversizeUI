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
//        LibraryItem(
//            TextFieldExtended("Text", text: .constant("Text")),
//            category: .control
//        )
        LibraryItem(
            Icon(.airplay),
            category: .control
        )
    }

    @LibraryContentBuilder
    public func modifiers(base: Text) -> [LibraryItem] {
        LibraryItem(
            base.fontStyle(.body, color: .onBackgroundHighEmphasis)
        )
    }

//    @LibraryContentBuilder
//    public func modifiers(base: Image) -> [LibraryItem] {
//        LibraryItem(
//            base.resizeToFill(width: 150, height: 150)
//        )
//    }
}
