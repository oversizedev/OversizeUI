//
// Copyright © 2023 Alexander Romanov
// Snackbar.swift, created on 21.05.2023
//

import SwiftUI

public struct Snackbar<Label, Actions>: View where Label: View, Actions: View {
    @Environment(\.screenSize) var screenSize

    private let text: String?

    private let label: Label?
    private let actions: Group<Actions>?

    @Binding private var isPresented: Bool

    @State private var bottomOffset: CGFloat = 0
    @State private var opacity: CGFloat = 0

    // MARK: Initializers

    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        self.actions = Group { actions() }
    }

    public var body: some View {
        HStack {
            if let text {
                Text(text)
                    .body(.medium)
                    .foregroundColor(.onPrimary)

            } else if let label {
                label
            }

            Spacer()

            if actions != nil {
                HStack(spacing: .xxSmall) {
                    actions
                        .buttonStyle(.quaternary)
                    #if !os(tvOS)
                        .controlSize(.mini)
                    #endif
                        .accent()
                }
            }
        }
        .padding(.leading, .medium)
        .padding(.trailing, .xSmall)
        .padding(.vertical, .xSmall)
        .background(
            RoundedRectangle(
                cornerRadius: .large,
                style: .continuous
            )
            .fill(Color.primary)
        )
        .padding(.small)
        .opacity(opacity)
        .offset(y: bottomOffset)
        .onChange(of: isPresented, perform: { present in
            if present {
                presentAnimated()
            } else {
                dismissAnimated()
            }
        })
    }

    private func presentAnimated() {
        withAnimation {
            bottomOffset = 0
            opacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            withAnimation {
                isPresented = false
            }
        }
    }

    private func dismissAnimated() {
        withAnimation {
            bottomOffset = 200
            opacity = 0
        }
    }
}

public extension Snackbar where Label == EmptyView, Actions == EmptyView {
    init(
        _ text: String,
        isPresented: Binding<Bool>
    ) {
        _isPresented = isPresented
        self.text = text
        label = nil
        actions = nil
    }
}

public extension Snackbar where Label == Text, Actions == EmptyView {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        actions = nil
    }
}

public extension Snackbar where Actions == EmptyView {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        actions = nil
    }
}

public extension Snackbar where Label == Text, Actions == Button<Text> {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == Text, Actions == Button<PrimitiveButtonStyleConfiguration.Label> {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Actions == Button<PrimitiveButtonStyleConfiguration.Label> {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Actions == Button<Text> {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView, Actions == Button<Text> {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        self.text = text
        label = nil
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView, Actions == Button<PrimitiveButtonStyleConfiguration.Label> {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        self.text = text
        label = nil
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        _isPresented = isPresented
        self.text = text
        label = nil
        self.actions = Group { actions() }
    }
}

public extension View {
    func snackbar(_ text: String, isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .bottom) {
            Snackbar(text, isPresented: isPresented)
        }
    }

    func snackbar(_ text: String, isPresented: Binding<Bool>, @ViewBuilder actions: () -> some View) -> some View {
        overlay(alignment: .bottom) {
            Snackbar(text, isPresented: isPresented, actions: actions)
        }
    }

    func snackbar(isPresented: Binding<Bool>, @ViewBuilder label: () -> some View) -> some View {
        overlay(alignment: .bottom) {
            Snackbar(isPresented: isPresented, label: label)
        }
    }

    func snackbar(isPresented: Binding<Bool>, @ViewBuilder label: () -> some View, @ViewBuilder actions: () -> some View) -> some View {
        overlay(alignment: .bottom) {
            Snackbar(isPresented: isPresented, label: label, actions: actions)
        }
    }
}
