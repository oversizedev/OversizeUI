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
        self._isPresented = isPresented
        self.text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
    
    
    public var body: some View {
        
        HStack {
            if let text {
                
                Text(text)
                    .body(.medium)
                    .foregroundColor(.onPrimaryHighEmphasis)
                
            } else if let label {
                label
            }
            
            Spacer()
            
            if actions != nil {
                HStack(spacing: .xxSmall) {
                    actions
                        .buttonStyle(.quaternary)
                        .controlSize(.mini)
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
        self._isPresented = isPresented
        self.text = text
        self.label = nil
        self.actions = nil
    }
}

public extension Snackbar where Label == Text, Actions == EmptyView {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label
    ) {
        self._isPresented = isPresented
        self.text = nil
        self.label = label()
        self.actions = nil
    }
}

public extension Snackbar where Actions == EmptyView {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label
    ) {
        self._isPresented = isPresented
        self.text = nil
        self.label = label()
        self.actions = nil
    }
}


public extension Snackbar where Label == Text, Actions == Button<Icon> {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == Text, Actions == Button<Text> {
    init(
        isPresented: Binding<Bool>,
        @ViewBuilder label: () -> Label,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.text = nil
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
        self._isPresented = isPresented
        self.text = nil
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
        self._isPresented = isPresented
        self.text = nil
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
        self._isPresented = isPresented
        self.text = nil
        self.label = label()
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView, Actions == Button<Icon> {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.text = text
        self.label = nil
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView, Actions == Button<Text> {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.text = text
        self.label = nil
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView, Actions == Button<PrimitiveButtonStyleConfiguration.Label> {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.text = text
        self.label = nil
        self.actions = Group { actions() }
    }
}

public extension Snackbar where Label == EmptyView {
    init(
        _ text: String,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: () -> Actions
    ) {
        self._isPresented = isPresented
        self.text = text
        self.label = nil
        self.actions = Group { actions() }
    }
}

public extension View {
    func snackbar(_ text: String, isPresented: Binding<Bool>) -> some View {
        self.overlay(alignment: .bottom) {
            Snackbar(text, isPresented: isPresented)
        }
    }
    
    func snackbar<Actions: View>(_ text: String, isPresented: Binding<Bool>, @ViewBuilder actions: () -> Actions) -> some View {
        self.overlay(alignment: .bottom) {
            Snackbar(text, isPresented: isPresented, actions: actions)
        }
    }
    
    func snackbar<Label: View>(isPresented: Binding<Bool>, @ViewBuilder label: () -> Label) -> some View {
        self.overlay(alignment: .bottom) {
            Snackbar(isPresented: isPresented, label: label)
        }
    }
    
    func snackbar<Label: View, Actions: View>(isPresented: Binding<Bool>, @ViewBuilder label: () -> Label, @ViewBuilder actions: () -> Actions) -> some View {
        self.overlay(alignment: .bottom) {
            Snackbar(isPresented: isPresented, label: label, actions: actions)
        }
    }
}

