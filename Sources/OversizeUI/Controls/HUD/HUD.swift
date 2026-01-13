//
// Copyright © 2023 Alexander Romanov
// HUD.swift, created on 22.05.2023
//

import SwiftUI

public struct HUD<Title, Icon>: View where Title: View, Icon: View {
    @Environment(\.screenSize) var screenSize

    private let content: HUDContent<Title, Icon>
    private let isAutoHide: Bool

    @Binding private var isPresented: Bool
    #if os(macOS)
    @State private var offset: CGFloat = 200
    #else
    @State private var offset: CGFloat = -200
    #endif

    @State private var opacity: CGFloat = 0

    // MARK: Initializers

    public init(
        autoHide: Bool = true,
        isPresented: Binding<Bool>,
        @ViewBuilder title: () -> Title,
        @ViewBuilder icon: () -> Icon
    ) {
        _isPresented = isPresented
        content = HUDContent(title: title(), icon: icon())
        isAutoHide = autoHide
    }

    public var body: some View {
        content
            .padding(.small)
            .opacity(opacity)
            .offset(y: offset)
            .onChange(of: isPresented) { present in
                if present {
                    if offset == 0 {
                        dismissAnimated()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            presentAnimated()
                        }
                    } else {
                        presentAnimated()
                    }
                } else {
                    dismissAnimated()
                }
            }
    }

    private func presentAnimated() {
        withAnimation {
            offset = 0
            opacity = 1
        }
        if isAutoHide {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    isPresented = false
                }
            }
        }
    }

    private func dismissAnimated() {
        withAnimation {
            #if os(macOS)
            offset = 200
            #else
            offset = -200
            #endif
            opacity = 0
        }
    }
}

public extension HUD where Title == EmptyView, Icon == EmptyView {
    init(
        _ text: String,
        autoHide: Bool = true,
        isPresented: Binding<Bool>
    ) {
        _isPresented = isPresented
        content = HUDContent(text)
        isAutoHide = autoHide
    }
}

public extension HUD where Title == EmptyView {
    init(
        _ text: String,
        autoHide: Bool = true,
        isPresented: Binding<Bool>,
        @ViewBuilder icon: () -> Icon
    ) {
        _isPresented = isPresented
        content = HUDContent(text, icon: icon())
        isAutoHide = autoHide
    }
}

public extension HUD where Icon == EmptyView {
    init(
        autoHide: Bool = true,
        isPresented: Binding<Bool>,
        @ViewBuilder title: () -> Title
    ) {
        _isPresented = isPresented
        content = HUDContent(title: title())
        isAutoHide = autoHide
    }
}

#if os(macOS)
@MainActor
public extension View {
    func hud(_ text: String, autoHide: Bool = true, isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .bottomTrailing) {
            HUD(text, autoHide: autoHide, isPresented: isPresented)
        }
    }

    func hud(_ text: String, isPresented: Binding<Bool>, @ViewBuilder icon: () -> some View) -> some View {
        overlay(alignment: .bottomTrailing) {
            HUD(text, isPresented: isPresented, icon: icon)
        }
    }

    func hud(isPresented: Binding<Bool>, @ViewBuilder title: () -> some View) -> some View {
        overlay(alignment: .bottomTrailing) {
            HUD(isPresented: isPresented, title: title)
        }
    }

    func hud(isPresented: Binding<Bool>, @ViewBuilder title: () -> some View, @ViewBuilder icon: () -> some View) -> some View {
        overlay(alignment: .bottomTrailing) {
            HUD(isPresented: isPresented, title: title, icon: icon)
        }
    }

    func hudLoader(_ text: String = "Loading", isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .bottomTrailing) {
            HUD(text, autoHide: false, isPresented: isPresented) {
                ProgressView()
            }
        }
    }
}
#else
public extension View {
    func hud(_ text: String, autoHide: Bool = true, isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .top) {
            HUD(text, autoHide: autoHide, isPresented: isPresented)
        }
    }

    func hud(_ text: String, isPresented: Binding<Bool>, @ViewBuilder icon: () -> some View) -> some View {
        overlay(alignment: .top) {
            HUD(text, isPresented: isPresented, icon: icon)
        }
    }

    func hud(isPresented: Binding<Bool>, @ViewBuilder title: () -> some View) -> some View {
        overlay(alignment: .top) {
            HUD(isPresented: isPresented, title: title)
        }
    }

    func hud(isPresented: Binding<Bool>, @ViewBuilder title: () -> some View, @ViewBuilder icon: () -> some View) -> some View {
        overlay(alignment: .top) {
            HUD(isPresented: isPresented, title: title, icon: icon)
        }
    }

    func hudLoader(_ text: String = "Loading", isPresented: Binding<Bool>) -> some View {
        overlay(alignment: .top) {
            HUD(text, autoHide: false, isPresented: isPresented) {
                ProgressView()
            }
        }
    }
}
#endif
