//
// Copyright © 2026 Alexander Romanov
// Icon.swift, created on 26.03.2026
//

import SwiftUI

public struct Icon: View {
    @Environment(\.iconColor) private var iconColor
    @Environment(\.iconSize) private var iconSize
    @Environment(\.sizeCategory) private var sizeCategory

    private let image: Image

    public var body: some View {
        image
            .renderingMode(.template)
            .foregroundColor(iconColor ?? Color.onSurfacePrimary)
            .frame(width: iconSize, height: iconSize)
    }
}

// MARK: - Inits

public extension Icon {
    init(_ image: Image) {
        self.image = image
    }

    init(_ systemName: String) {
        image = .init(systemName: systemName)
    }
}

// MARK: - Previews

#Preview {
    struct Container: View {
        var body: some View {
            VStack {
                Circle()
                    .fill(Color.secondary)
                    .frame(width: 20.0, height: 20.0)
                    .overlay(
                        Icon(Image.Base.info)
                            .iconSize(.xSmall),
                        alignment: .center
                    )

                Icon("info.circle.fill")

                Icon(Image.Base.eye)
                    .iconColor(Color.onSurfacePrimary)
                    .iconSize(.small)

                Icon(Image.Base.Eye.slash)
                    .iconColor(Color.onSurfacePrimary)

                Icon(Image.Base.document)
                    .iconColor(Color.onSurfaceSecondary)
                    .iconSize(custom: 72.0)

                Icon(Image.Base.attach)
            }
        }
    }
    return Container()
}
