//
// Copyright © 2026 Alexander Romanov
// ListSection.swift, created on 19.03.2026
//

import SwiftUI

public struct ListSectionFooter<Description: StringProtocol>: View {
    private let description: Description

    // MARK: Initializer

    public init(description: Description) {
        self.description = description
    }

    public var body: some View {
        @ViewBuilder var descriptionView: some View {
            Text(description)
                .footnote()
                .foregroundStyle(Color.onBackgroundSecondary)
        }

        return descriptionView
    }
}
