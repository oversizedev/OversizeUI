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
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
struct ResolvedSectionStyle {
    let titlePosition: SectionTitlePosition
    let isBordered: Bool
    let titleSeparator: Visibility
    let contentMarginsVisibility: Visibility
    let titleMargins: SwiftUI.EdgeInsets
    let backgroundStyle: SectionBackgroundStyle
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
extension SectionConfiguration {
    func resolvedStyle(environment: EnvironmentValues) -> ResolvedSectionStyle {
        .init(
            titlePosition: containerValues.sectionTitlePosition ?? environment.sectionTitlePosition,
            isBordered: containerValues.isBordered ?? environment.isBordered,
            titleSeparator: containerValues.sectionTitleSeparator ?? environment.sectionTitleSeparator,
            contentMarginsVisibility: containerValues.sectionContentMarginsVisibility ?? environment.sectionContentMarginsVisibility,
            titleMargins: containerValues.sectionTitleMargins ?? environment.sectionTitleMargins,
            backgroundStyle: containerValues.sectionBackgroundStyle ?? environment.sectionBackgroundStyle
        )
    }
}
