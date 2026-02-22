//
// Copyright © 2021 Alexander Romanov
// ContentView.swift, created on 02.04.2022
//

import SwiftUI

public struct ContentView<A: View>: View {
    @Environment(\.multilineTextAlignment) var multilineTextAlignment

    private let image: Image?
    private let title: String
    private let subtitle: String?
    private let actions: Group<A>?

    public init(
        image: Image? = nil,
        title: String,
        subtitle: String? = nil,
        @ViewBuilder actions: @escaping () -> A
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.actions = Group { actions() }
    }

    public var body: some View {
        VStack(alignment: vStackAlignment, spacing: .large) {
            if let image {
                image
                    .resizable()
                    .frame(width: 128, height: 128, alignment: .bottom)
            }

            TextBox(
                title: title,
                subtitle: subtitle,
                spacing: .xxSmall
            )

            if let actions {
                VStack(spacing: .small) {
                    actions
                    #if !os(tvOS)
                    .controlSize(.large)
                    #endif
                }
            }
        }
    }

    var vStackAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading: .leading
        case .center: .center
        case .trailing: .trailing
        }
    }
}

public extension ContentView where A == EmptyView {
    init(
        image: Image? = nil,
        title: String,
        subtitle: String? = nil
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        actions = nil
    }
}
