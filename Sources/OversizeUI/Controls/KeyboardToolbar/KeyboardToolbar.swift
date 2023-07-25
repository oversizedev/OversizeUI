//
// Copyright © 2021 Alexander Romanov
// KeyboardToolbar.swift, created on 25.07.2023
//

import SwiftUI

public struct KeyboardToolbar<A>: View where A: View {
    private let actions: Group<A>?
    private let doneAction: (() -> Void)?

    public init(
        @ViewBuilder actions: @escaping () -> A,
        doneAction: (() -> Void)? = nil
    ) {
        self.actions = Group { actions() }
        self.doneAction = doneAction
    }

    public var body: some View {
        HStack(spacing: .xSmall) {
            if actions != nil {
                HStack(spacing: .xxxSmall) {
                    actions
                        .buttonStyle(.quaternary)
                        .controlBorderShape(.capsule)
                        .controlSize(.mini)
                }
            }

            Spacer()

            if doneAction != nil {
                Button {
                    doneAction?()
                } label: {
                    Text("Done")
                }
                .buttonStyle(.quaternary)
                .controlBorderShape(.capsule)
                .accent()
                .controlSize(.mini)
            }
        }
        .padding(.horizontal, .small)
        .padding(.vertical, .xxSmall)
        .background(Color.surfacePrimary)
        .shadowElevaton(.z1)
    }
}
