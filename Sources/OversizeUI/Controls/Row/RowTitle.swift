//
// Copyright © 2021 Aleksandr Romanov
// RowTitle.swift, created on 04.04.2023
//

import SwiftUI

public struct RowTitle: View {
    private let title: String
    private var titleButtonPosition: SectionViewTitleButtonPosition = .trailing
    private var titleButton: SectionViewTitleButton?

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        HStack(spacing: titleButtonPosition == .leading ? .zero : .xxxSmall) {
            titleLabelView(titleButton)

            if titleButtonPosition == .trailing {
                Spacer()
            }

            if let titleButton {
                titleButtonView(titleButton)
            }

            if titleButtonPosition == .leading {
                Spacer()
            }
        }
        .padding(.vertical, .xSmall)
        .padding(.horizontal, .medium)
    }

    @ViewBuilder
    private func titleLabelView(_ button: SectionViewTitleButton?) -> some View {
        if let button {
            switch button {
            case let .arrow(action), let .title(_, action):
                Button {
                    action()
                } label: {
                    Text(title)
                        .font(.title2.bold())
                        .foregroundColor(.onSurfacePrimary)
                }
                .buttonStyle(.scale)
            }
        } else {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.onSurfacePrimary)
        }
    }

    @ViewBuilder
    private func titleButtonView(_ button: SectionViewTitleButton) -> some View {
        switch button {
        case let .arrow(action):
            Button {
                action()
            } label: {
                IconDeprecated(.chevronRight)
                    .iconColor(.onSurfaceSecondary)
                    .offset(y: titleButtonPosition == .leading ? 1.5 : 0)
            }
            .buttonStyle(.scale)
        case let .title(text, action):
            #if os(tvOS)
            Button(text) { action() }
                .buttonStyle(.tertiary)
                .controlBorderShape(.capsule)
            #else
            Button(text) { action() }
                .buttonStyle(.tertiary)
                .controlSize(.small)
                .controlBorderShape(.capsule)
            #endif
        }
    }
}

public extension RowTitle {
    func sectionTitleButton(_ button: SectionViewTitleButton, position: SectionViewTitleButtonPosition = .trailing) -> RowTitle {
        var control = self
        control.titleButton = button
        control.titleButtonPosition = position
        return control
    }
}

struct RowTitle_Previews: PreviewProvider {
    static var previews: some View {
        RowTitle("Title")
    }
}
