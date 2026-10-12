//
// Copyright © 2026 Alexander Romanov
// SectionStyleContainerValues.swift, created on 04.09.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public extension ContainerValues {
    @Entry var sectionTitlePosition: SectionTitlePosition?
    @Entry var isBordered: Bool?
    @Entry var sectionTitleSeparator: Visibility?
    @Entry var sectionContentMarginsVisibility: Visibility?
    @Entry var sectionTitleMargins: SwiftUI.EdgeInsets?
    @Entry var sectionBackgroundStyle: SectionBackgroundStyle?
    @Entry var sectionRowsPaddingVisibility: Visibility?
}
