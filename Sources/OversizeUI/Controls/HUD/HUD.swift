//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public class HUDState: ObservableObject {
    @Published public var isPresented: Bool = false
    public var title: String
    public var icon: Icons

    public init(title: String = "", icon: Icons = .bell) {
        self.title = title
        self.icon = icon
    }

    public func show(title: String, icon: Icons = .bell) {
        self.title = title
        self.icon = icon
        withAnimation {
            isPresented = true
        }
    }
}

public extension View {
    func hud<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        ZStack(alignment: .top) {
            self
            if isPresented.wrappedValue {
                HUD(content: content)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
                    .zIndex(1)
            }
        }
    }
}

public struct HUD<Content: View>: View {
    public let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding(.horizontal, .xSmall)
            .padding(.all, .small)
            .background(
                Capsule()
                    .foregroundColor(Color.surfacePrimary)
                    .shadowElevaton(.z2)
            )
    }
}
