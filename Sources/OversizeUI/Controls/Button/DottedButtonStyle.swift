//
// Copyright © 2026 Alexander Romanov
// DottedButtonStyle.swift, created on 05.09.2026
//

import SwiftUI

public struct DottedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @State private var isHover = false

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .body()
            .foregroundColor(isHover ? .onSurfacePrimary : .onSurfaceSecondary)
            .padding(.medium)
            .frame(maxWidth: .infinity, alignment: .center)
            .dottedBorder(color: isHover ? .border : .border.opacity(0.95))
            .opacity(isEnabled == false ? 0.3 : 1.0)
            .contentShape(Rectangle())
            #if os(macOS)
            .onHover { hover in
                isHover = hover
            }
            #endif
    }
}

public extension ButtonStyle where Self == DottedButtonStyle {
    static var dotted: DottedButtonStyle {
        .init()
    }
}

#Preview {
    VStack(spacing: .medium) {
        Button("Create a new Subscription Group") {}
            .buttonStyle(.dotted)

        Button("Disabled") {}
            .buttonStyle(.dotted)
            .disabled(true)
    }
    .padding(.medium)
    .background(Color.backgroundSecondary)
}
