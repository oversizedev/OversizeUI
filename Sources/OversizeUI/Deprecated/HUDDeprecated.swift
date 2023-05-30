//
// Copyright © 2021 Alexander Romanov
// HUD.swift, created on 26.04.2021
//

import SwiftUI

public enum HUDType {
    case hud, alert
}

public class HUDDeprecated: ObservableObject {
    @Published public var isPresented: Bool = false
    public var title: String
    public var icon: IconsNames?
    public var image: Image?
    @Published public var type: HUDType = .hud

    public init(title: String = "") {
        self.title = title
        type = .hud
    }

    public init(title: String = "", icon: IconsNames) {
        self.title = title
        self.icon = icon
        type = .hud
    }

    public init(title: String = "", image: Image) {
        self.title = title
        self.image = image
        type = .alert
    }

    public func show(title: String) {
        self.title = title
        type = .hud
        withAnimation {
            isPresented = true
        }
    }

    public func show(title: String, icon: IconsNames, type: HUDType = .hud) {
        self.title = title
        self.icon = icon
        self.type = type
        withAnimation {
            isPresented = true
        }
    }

    public func show(title: String, image: Image, type: HUDType = .hud) {
        self.title = title
        self.image = image
        self.type = type
        withAnimation {
            isPresented = true
        }
    }
}

public extension View {
    func hudDeprecated(isPresented: Binding<Bool>,
             type: Binding<HUDType>,
             @ViewBuilder content: () -> some View) -> some View
    {
        ZStack(alignment: type.wrappedValue == .hud ? .top : .center) {
            self
            // .blur(radius: type.wrappedValue == .alert && isPresented.wrappedValue ? 10 : 0)

            if isPresented.wrappedValue {
                HUDSurfaceView(type: type, content: content)
                    .transition(
                        type.wrappedValue == .hud
                            ? AnyTransition.move(edge: .top).combined(with: .opacity)
                            : AnyTransition.opacity.animation(.default)
                    )
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

public struct HUDSurfaceView<Content: View>: View {
    public let content: Content
    @Binding public var type: HUDType

    public init(type: Binding<HUDType>, @ViewBuilder content: () -> Content) {
        _type = type
        self.content = content()
    }

    public var body: some View {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            content
                .padding(.top, topPadding)
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, bottomPadding)
                .background(backgroundMaterial(type: type),
                            in: backgroundShape(type: type))
                .shadowElevaton(type == .hud ? .z2 : .z0)
        } else {
            content
                .padding(.top, topPadding)
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, bottomPadding)
                .background(background(type: type))
        }
        #else
        content
            .padding(.top, topPadding)
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, bottomPadding)
            .background(background(type: type))
        #endif
    }

    #if os(iOS)
    @available(iOS 15.0, *)
    private func backgroundMaterial(type: HUDType) -> Material {
        switch type {
        case .hud:
            return .regular
        case .alert:
            return .ultraThinMaterial
        }
    }
    #endif

    private func backgroundShape(type: HUDType) -> AnyShape {
        switch type {
        case .hud:
            return AnyShape(Capsule())

        case .alert:
            return AnyShape(RoundedRectangle(cornerRadius: Radius.medium, style: .continuous))
        }
    }

    @ViewBuilder
    private func background(type: HUDType) -> some View {
        switch type {
        case .hud:
            Capsule()
                .foregroundColor(Color.surfacePrimary)
                .shadowElevaton(.z2)
        case .alert:
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Color.surfacePrimary)
                .shadowElevaton(.z4)
        }
    }

    var horizontalPadding: Space {
        switch type {
        case .hud:
            return .medium
        case .alert:
            return .medium
        }
    }

    var topPadding: Space {
        switch type {
        case .hud:
            return .small
        case .alert:
            return .xLarge
        }
    }

    var bottomPadding: Space {
        switch type {
        case .hud:
            return .small
        case .alert:
            return .xLarge
        }
    }
}

public struct HUDContent: View {
    public var title: String
    // public var icon: Icons?
    public var image: Image?
    public var type: HUDType

    public init(title: String, image: Image?, type: HUDType = .hud) {
        self.title = title
        self.image = image
        self.type = type
    }

    public var body: some View {
        // Text(title)
        // background(background(type: type))
        background
    }

    private var background: some View {
        Group {
            switch type {
            case .hud:
                HStack {
//                if let icon = hudState.icon {
//                    IconDeprecated(icon, color: .onSurfaceHighEmphasis)
//                }

                    Text(title)
                        .body()
                        .onSurfaceHighEmphasisForegroundColor()
                }
            case .alert:
                VStack(spacing: .large) {
                    if let image {
                        image
                    }

                    Text(title)
                        .title3()
                        .onSurfaceHighEmphasisForegroundColor()
                }
                .frame(minWidth: 225)
            }
        }
    }
}
